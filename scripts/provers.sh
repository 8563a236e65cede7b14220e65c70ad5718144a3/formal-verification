#!/usr/bin/env bash

# If build directory exists, remove everything in it.
if [ -d "scripts/provers" ]; then
	rm -rf scripts/provers/*
fi

# Create a build directory for provers
if [ ! -d "scripts/provers" ]; then
	mkdir scripts/provers
fi


(
	cd scripts/provers
	
	# Why3 Platform
	wget https://gforge.inria.fr/frs/download.php/file/38367/why3-1.3.3.tar.gz
	tar -zxvf why3-1.3.3.tar.gz
	
	# Alt Ergo SMT Prover
	wget https://github.com/OCamlPro/alt-ergo/archive/2.3.3.tar.gz
	tar -zxvf 2.3.3.tar.gz

	# CVC3 SMT Prover
	wget https://cs.nyu.edu/acsys/cvc3/releases/2.4.1/cvc3-2.4.1.tar.gz
	tar -zxvf cvc3-2.4.1.tar.gz

	# CVC4 SMT Prover
	wget https://github.com/CVC4/CVC4/archive/1.7.tar.gz
	tar -zxvf 1.7.tar.gz
	
	# Symfpu
	wget https://github.com/martin-cs/symfpu/archive/master.zip
	tar -zxvf master.zip
	
	# Z3 Theorem Prover
	wget https://github.com/Z3Prover/z3/archive/z3-4.8.6.tar.gz
	tar -zxvf z3-4.8.6.tar.gz
	
	# Coq Proof Assistance
	wget https://github.com/coq/coq/archive/V8.12.0.tar.gz
	tar -zxvf V8.12.0.tar.gz
	
	# Frama-C Platform
	wget https://frama-c.com/download/frama-c-21.1-Scandium.tar.gz
	tar -zxvf frama-c-21.1-Scandium.tar.gz
	
	# Alt Ergo Dependencies
	apt install ocaml opam libgtksourceview2.0-dev
	opam install psmt2-frontend zarith camlzip menhir ocplib-simplex stdlib-shims
	
	# Coq dependencies
	apt install libipc-system-simple-perl libstring-shellquote-perl
	opam install num ocamlfind lablgtk conf-gtksourceview \
		lablgtk3 lablgtk3-sourceview3
	 
	# Frama-C dependencies
	apt install autoconf debianutils graphviz libexpat1-dev libgmp-dev \
		libgnomecanvas2-dev libgtk2.0-dev libgtksourceview2.0-dev \
		m4 perl pkg-config zlib1g-dev
	opam install ocamlgraph yojson
		
	
	# Install Coq
	(
		cd coq-8.12.0
		./configure
		make
		make install
	)
	
	# Install Alt Ergo
	(
		cd alt-ergo-2.3.3/sources
		./configure
		sed -i -r \
			"s/Pervasives\\./Stdlib./g" \
			$(grep -R -E "Pervasives\\." | grep -v "Binary file" | awk '{print $1}' | sed -r "s/:>?//g")
		make
		make install
	)
	
	# Install Z3
	(
		cd z3-z3-4.8.6/
		python scripts/mk_make.py
		cd build
		make
		make install
	)
	
	# Install CVC3
	(
		cd cvc3-2.4.1
		./configure
		make CXXFLAGS="-std=gnu++98"
		# Need to change src/parser files to use *_defs.h
		make install
	)
	
	# Install CVC4
	(
		cd CVC4-1.7
		./contrib/get-antlr-3.4
		./contrib/get-symfpu
		./contrib/get-cadical
		./contrib/get-cryptominisat
		./contrib/get-lfsc-checker
		./configure.sh --symfpu --cadical --cryptominisat --lfsc
		cd build
		make -j5
	)
	
	# Install Symfpu
	(
		cd symfpu-master
		mkdir /usr/local/include/symfpu
		cp -r ./* /usr/local/include/symfpu
	)
	
	# Install Why3
	(
		cd why3-1.3.3
		opam remove lablgtk3 lablgtk3-sourceview3
		./configure
		make
		make install
		why3 config --detect-provers		
	)
	
	# Install Frama-C
	(
		cd frama-c-21.1-Scandium
		opam install why3
		./configure
		make
		make install
		opam install lablgtk3 lablgtk3-sourceview3
	)

)


