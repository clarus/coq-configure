all:
	ocamlbuild coqConfigure.native -use-ocamlfind -pkgs str

clean:
	ocamlbuild -clean