@[Include(
  "git2.h",
  "git2/global.h",
  prefix: %w(git_ GIT_ Git),
  flags: "-I./vendor/libgit2/include")]
@[Link("git2")]
@[Link(ldflags: "-L./vendor/libgit2/build/")]
lib LibGit2
end
