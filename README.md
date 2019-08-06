# OCaml Time API Service

This is a very small service which uses the [OCaml Unix Time
API](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Unix.html) and
[Opium Web Toolkit](https://github.com/rgrinberg/opium) to translate
Epoch time into a small subset of the tm data structure which is
returned as JSON.

This is intended as a demonstration project.

## Compiling

This uses the Dune build system for OCaml.  To build this, you will
need to have Opium installed via Opam then:

```OCaml
dune build src/main.exe
```
