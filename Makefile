all:
	ocamlbuild coqConfigure.native -pp camlp5o.opt -use-ocamlfind -pkgs str

clean:
	ocamlbuild -clean