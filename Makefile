crystal-git: bindings
	crystal build src/crystal-git.cr

bindings: deps
	echo '@[Link("git2", ldflags: "-L#{__DIR__}/../../vendor/libgit2/build/")]' > src/crystal-git/libgit2.cr
	crystal run --link-flags "-L`dirname $(shell find /usr/local/Cellar/llvm* -name libclang* | head -n1)`" libs/crystal_lib/main.cr -- vendor/libgit2-bindings.cr >> src/crystal-git/libgit2.cr

deps:
	mkdir -p vendor/libgit2/build && cd vendor/libgit2/build && cmake .. && cmake --build .
	crystal deps

clean:
	[ -d vendor/libgit2/build/ ] && rm -rf vendor/libgit2/build/
	[ -d libs/ ] && rm -rf libs/
	rm -rf crystal-git

spec: bindings
	crystal spec

.PHONY: spec
