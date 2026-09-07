# Install Opam

First, one must install opam:

Link - https://opam.ocaml.org/doc/Install.html

``` sh
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
```

# Initialize opam

```sh
opam init
```

# Create Switch

``` sh
opam switch create cs-462 5.4.1
```

# Install dune, utop

``` sh
opam install dune utop user-setup
```

# Initialize project

If you want to create a new project from scratch (without using this template), do:

``` sh
dune init proj ocaml-intro
cd ocaml-intro
```

# Build

``` sh
dune build
```

# Execute hello world

``` sh
dune exec -- ocaml-intro
```

# Appendix

- if utop not working:
  https://stackoverflow.com/questions/20738880/ocaml-cant-run-utop-after-installing-it


## Installation on Windows

- Ubuntu 26.04 WSL is recommended

In the WSL run:

``` sh
sudo apt install build-essential
```

