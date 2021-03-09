CC=g++-10
FLAGS=-std=c++20 -Wall -pedantic -Werror -O3
INCLUDES=-Ideps/includes

deps/includes/clon: 
	git clone https://github.com/padget/clon deps/clon
	mkdir -p $@
	cp deps/clon/clon.hpp $@
	cp deps/clon/format.hpp $@
	cp deps/clon/format-types.hpp $@
	rm -rf deps/clon

deps/includes/base64: 
	git clone https://github.com/padget/base64 deps/base64
	mkdir -p $@
	cp deps/base64/base64.hpp $@
	rm -rf deps/base64

deps/includes/ares: 
	git clone https://github.com/padget/ares deps/ares
	mkdir -p $@
	cp deps/ares/ares.hpp $@
	rm -rf deps/ares

.PHONY: prepare
prepare: deps/includes/clon deps/includes/base64 deps/includes/ares

bin:
	mkdir bin

bin/clon: src/cpp/clon.cpp bin prepare
	${CC} -o $@ $< ${INCLUDES} ${FLAGS} 

bin/base64: src/cpp/base64.cpp bin prepare
	${CC} -o $@ $< ${INCLUDES} ${FLAGS} 

bin/ares: src/cpp/ares.cpp bin prepare
	${CC} -o $@ $< ${INCLUDES} ${FLAGS} 

.PHONY: build build-scripts
build-scripts: 
	cp -r src/scripts/* bin/

build: bin/clon bin/base64 bin/ares build-scripts

.PHONY: clean
clean: 
	rm -rf deps
	rm -rf bin
	


