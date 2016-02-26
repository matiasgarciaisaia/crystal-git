class Git::Repository
  def self.init(path = ".", bare = false)
    if LibGit2.repository_init(out repository, path, bare ? 0 : 1) == 0
      new(repository)
    else
      # TODO: check giterr_last
      raise "Couldn't init repository at #{path}"
    end
  end

  def self.open(path = ".")
    if LibGit2.repository_open(out repository, path) == 0
      new(repository)
    else
      raise "Couldn't open repository at #{path}"
    end
  end

  def initialize(@repo : LibGit2::X_Repository)
  end

  def finalize
    LibGit2.repository_free(@repo)
  end

  def to_unsafe
    @repo
  end
end
