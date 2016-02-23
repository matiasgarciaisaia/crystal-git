crystal-git: bindings
	crystal build src/crystal-git.cr

bindings: deps
	crystal libs/crystal_lib/main.cr -- vendor/libgit2-bindings.cr > src/crystal-git/libgit2.cr

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
