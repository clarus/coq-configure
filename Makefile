default:
	ocamlbuild coqConfigure.byte coqConfigure.native -pp camlp5o.opt -use-ocamlfind -pkgs str

install:
	ocamlfind install coq-configure META coqConfigure.byte coqConfigure.native

clean:
	ocamlbuild -clean