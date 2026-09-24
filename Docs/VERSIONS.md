# Toolchain versions

- F*: 2025.10.06 (opam: `opam install fstar.2025.10.06`)
- karamel: commit 254e099bd586b17461845f6b0cab44c3ef5080e9
  (pin sourced from hacl-star's flake.nix)
- OCaml: 4.14.2
- Z3: 4.13.3 and 4.8.5 (via karamel's get_fstar_z3.sh)
- GCC: 16.2.1

## Rebuild from scratch
```bash
# Install opam through your package manager
opam switch create fstar 4.14.2
eval $(opam env --switch=fstar)
opam install fstar.2025.10.06 -y
git clone https://github.com/FStarLang/karamel.git ~/karamel
cd ~/karamel && git checkout 254e099bd586b17461845f6b0cab44c3ef5080e9
opam install --deps-only . -y
export FSTAR_HOME=~/.opam/fstar
make -j$(nproc)
```