# Everything was written by Claude, I would rather run a 5k for 21 days in a row while dehydrated than figure this out by looking things up

cmake_minimum_required(VERSION 3.25)
project(FStar_Cryptography C)

set(FSTAR_EXE "fstar.exe")
set(KRML_EXE "$ENV{HOME}/karamel/out/bin/krml")
set(KRML_LIB "$ENV{HOME}/karamel/out/lib/krml")
set(FSTAR_ULIB "$ENV{HOME}/.opam/fstar/lib/fstar/ulib")

# Only YOUR modules go here — LowStar.Printf is handled separately below
# since it lives in F*'s ulib, not your project directory.
set(MODULE_NAMES "Utils" "Andie")

# LowStar.Printf.fst lives in F*'s ulib (${FSTAR_HOME}/lib/fstar/ulib/LowStar.Printf.fst),
# NOT in karamel's krmllib. Its C implementation (lowstar_printf.c) is in
# krmllib/dist/generic/ instead. Extract it separately from your own modules.

set(OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/out")
set(APP_BIN "${CMAKE_CURRENT_BINARY_DIR}/andie")
set(CACHE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/.fstar-cache")

set(KRML_FILES "${OUT_DIR}/LowStar_Printf.krml")
foreach(MOD ${MODULE_NAMES})
    list(APPEND KRML_FILES "${OUT_DIR}/${MOD}.krml")
endforeach()

add_custom_target(compile_andie ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory ${OUT_DIR}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CACHE_DIR}
)

# Extract LowStar.Printf explicitly from F*'s ulib
add_custom_command(TARGET compile_andie
    COMMAND ${FSTAR_EXE} --include ${KRML_LIB} --include ${CMAKE_CURRENT_SOURCE_DIR} --cache_dir ${CACHE_DIR} --codegen krml --extract_module LowStar.Printf --odir ${OUT_DIR} ${FSTAR_ULIB}/LowStar.Printf.fst
    COMMENT "Extracting LowStar.Printf"
)

# Verify + extract your own modules
foreach(MOD ${MODULE_NAMES})
    add_custom_command(TARGET compile_andie
        COMMAND ${FSTAR_EXE} --include ${KRML_LIB} --include ${CMAKE_CURRENT_SOURCE_DIR} --cache_dir ${CACHE_DIR} --cache_checked_modules ${CMAKE_CURRENT_SOURCE_DIR}/${MOD}.fst
        COMMAND ${FSTAR_EXE} --include ${KRML_LIB} --include ${CMAKE_CURRENT_SOURCE_DIR} --cache_dir ${CACHE_DIR} --codegen krml --extract_module ${MOD} --odir ${OUT_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${MOD}.fst
        COMMENT "Verifying + extracting ${MOD}"
    )
endforeach()

# Link everything into the final binary
add_custom_command(TARGET compile_andie
    COMMAND ${KRML_EXE} -no-prefix Andie -warn-error -2 ${KRML_FILES} ${KRML_LIB}/dist/generic/libkrmllib.a ${KRML_LIB}/dist/generic/lowstar_printf.c -o ${APP_BIN}
    COMMENT "Linking final binary"
)

# Fast verify-only target — just type-checks, no extraction/compile/link
add_custom_target(verify)
foreach(MOD ${MODULE_NAMES})
    add_custom_command(TARGET verify
        COMMAND ${FSTAR_EXE} --include ${KRML_LIB} --include ${CMAKE_CURRENT_SOURCE_DIR} --cache_dir ${CACHE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${MOD}.fst
        COMMENT "Verifying ${MOD}"
    )
endforeach()