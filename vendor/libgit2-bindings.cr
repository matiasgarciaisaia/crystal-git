@[Include(
  "git2.h",
  "git2/global.h",
  prefix: %w(git_ GIT_ Git),
  flags: "-I./vendor/libgit2/include")]
lib LibGit2
end
