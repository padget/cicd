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

.PHONY: prepare
prepare: deps/includes/clon deps/includes/base64

bin:
	mkdir bin

bin/clon: src/cpp/clon.cpp bin prepare
	${CC} -o $@ $< ${INCLUDES} ${FLAGS} 

bin/base64: src/cpp/base64.cpp bin prepare
	${CC} -o $@ $< ${INCLUDES} ${FLAGS} 

.PHONY: build
build: bin/clon bin/base64

.PHONY: clean
clean: 
	rm -rf deps
	rm -rf bin
	


