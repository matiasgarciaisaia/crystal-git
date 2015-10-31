# Execute like `crystal ../crystal_lib/src/main.cr -- vendor/bindings_generator.cr > src/crystal-git/libgit2.cr`
@[Include("git2.h", prefix: %w(git_ GIT_ Git), flags: "-I./libgit2/include")]
@[Link("git2")]
lib LibGit2
end
