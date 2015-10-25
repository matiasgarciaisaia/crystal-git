require "./crystal-git/*"

module Git
  LibGit2.libgit2_init

  SORT_NONE = LibGit2::SORTNONE
  SORT_TOPOLOGICAL = LibGit2::SORTTOPOLOGICAL
  SORT_TIME = LibGit2::SORTTIME
  SORT_REVERSE = LibGit2::SORTREVERSE

  extend self

  def version
    LibGit2.libgit2_version(out major, out minor, out revision)
    [major, minor, revision]
  end

  def features
    features_byte = LibGit2.libgit2_features
    features = [] of Symbol
    features << :threads if features_byte & LibGit2::FEATURETHREADS > 0
    features << :https if features_byte & LibGit2::FEATUREHTTPS > 0
    features << :ssh if features_byte & LibGit2::FEATURESSH > 0
    features
  end

  def valid_full_oid? str_oid
    errorcode = LibGit2.oid_fromstr(out oid, str_oid.to_s)
    errorcode == 0
  end

  def minimize_oid oids, min_length = 7
    minimize_oid oids, min_length, do end
  end

  def minimize_oid oids, min_length = 7
    if oids.is_a? Array
      shorten = LibGit2.oid_shorten_new min_length
      minimal_length = oids.inject(min_length) do |memo, oid|
        LibGit2.oid_shorten_add shorten, oid
      end
      oids.each { |oid| yield oid[0..minimal_length - 1] }
      minimal_length
    end
  end

  def prettify_message message, strip = "#"
    strip_comments = 1
    comment_char = '#'
    case strip
    when Bool
      strip_comments = strip ? 1 : 0
    when Char
      comment_char = strip
    when String
      comment_char = strip[0]
    end
    cleared_message = Buf.new
    LibGit2.message_prettify(cleared_message, message, strip_comments, comment_char.ord.to_u8)
    cleared_message.to_s
  end

  class Buf
    def initialize(@buf = LibGit2::Buf.new ptr: nil, asize: 0, size: 0 : LibGit2::Buf)
    end

    def to_s
      String.new(Slice.new @buf.ptr, @buf.size)
    end

    def to_unsafe
      pointerof(@buf)
    end
  end
end
