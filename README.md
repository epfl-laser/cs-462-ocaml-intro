# Install Opam

First, one must install opam:

Link - https://opam.ocaml.org/doc/Install.html

We recommend following the directions in the above link depending on your machine.

``` sh
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
```

# Initialize opam

```sh
opam init -y
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

# Test Local Definitions

To play with definitions from this project, run:

``` sh
dune utop
```

Then you can import/load files (*modules*) from `lib` via `open Mylib.<capital filename>;;`.
For instance, to open `lib/days.ml`, do `open Mylib.Days;;` in utop.

To exit utop, do `#quit;;`.

For help with utop, see: https://ocaml.org/docs/toplevel-introduction

# Appendix

- if utop is not working:
https://stackoverflow.com/questions/20738880/ocaml-cant-run-utop-after-installing-it

- For more OCaml help/resources, see:
  - [CS 3110 OCaml book](https://cs3110.github.io/textbook/cover.html)
  - [A Tour of OCaml](https://ocaml.org/docs/tour-of-ocaml)


## Installation on Windows

- Ubuntu 26.04 WSL is recommended
  In the WSL run:
``` sh
sudo apt install build-essential unzip
```

