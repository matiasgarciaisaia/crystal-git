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
end
