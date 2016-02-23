require "./crystal-git/*"

module Git
  LibGit2.libgit2_init

  extend self

  def version
    LibGit2.libgit2_version(out major, out minor, out revision)
    [major, minor, revision]
  end

  def features
    features_byte = LibGit2.libgit2_features
    features = [] of Symbol
    features << :threads if features_byte & LibGit2::FeatureThreads > 0
    features << :https if features_byte & LibGit2::FeatureHttps > 0
    features << :ssh if features_byte & LibGit2::FeatureSsh > 0
    features << :nsec if features_byte & LibGit2::FeatureNsec > 0
    features
  end

  def valid_full_oid?(str_oid)
    errorcode = LibGit2.oid_fromstr(out oid, str_oid.to_s)
    errorcode == 0
  end
end
