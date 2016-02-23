require "./spec_helper"

describe Git do
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
end
