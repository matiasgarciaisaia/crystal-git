require "./spec_helper"

describe Git do
  it "reports libgit2's version" do
    version = Git.version
    version.should eq([0, 23, 0])
  end
end
