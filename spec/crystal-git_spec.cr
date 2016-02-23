require "./spec_helper"

describe Git do

  @@oids = [
    "d8786bfc974aaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "d8786bfc974bbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
    "d8786bfc974ccccccccccccccccccccccccccccc",
    "68d041ee999cb07c6496fbdd4f384095de6ca9e1"
  ]

  it "reports libgit2's version" do
    version = Git.version
    version.should eq([0, 23, 0])
  end

  it "exposes libgit2's features" do
    features = Git.features
    features.should be_a(Array(Symbol))
  end

  it "validates full oids" do
    Git.valid_full_oid?("ce08fe4884650f067bd5703b6a59a8b3b3c99a09").should be_true
    Git.valid_full_oid?("nope").should be_false
    Git.valid_full_oid?("ce08fe4884650f067bd5703b6a59a8b3b3c99a0").should be_false
  end

  it "converts hex strings to raw bytes" do
    raw = Git.hex_to_raw("ce08fe4884650f067bd5703b6a59a8b3b3c99a09")
    raw.to_s.should eq("ce08fe4884650f067bd5703b6a59a8b3b3c99a09")
  end

  it "minimizes oids with no block given" do
    Git.minimize_oid(@@oids).should eq(12)
  end

  it "minimizes oids with min_length" do
    Git.minimize_oid(@@oids, 20).should eq(20)
  end

  it "minimizes oids with a block given" do
    minimized_oids = [] of String
    Git.minimize_oid(@@oids) { |oid| minimized_oids << oid }
    minimized_oids.should eq([
      "d8786bfc974a",
      "d8786bfc974b",
      "d8786bfc974c",
      "68d041ee999c"
    ])
  end

  it "exposes sorting constants" do
    Git::SORT_NONE.should eq(0)
    Git::SORT_TOPOLOGICAL.should eq(1)
    Git::SORT_TIME.should eq(2)
    Git::SORT_REVERSE.should eq(4)
  end
end
