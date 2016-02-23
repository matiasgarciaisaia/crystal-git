require "./crystal-git/*"

module Git
  LibGit2.libgit2_init

  extend self

  def version
    LibGit2.libgit2_version(out major, out minor, out revision)
    [major, minor, revision]
  end
end
