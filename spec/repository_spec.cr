require "./spec_helper"

describe Git::Repository do

  it "opens an existing repository" do
    Git::Repository.open(".").should be_a(Git::Repository)
  end

  it "inits a repository" do
    Git::Repository.init("/tmp/some-test-repo").should be_a(Git::Repository)
  end

  it "can't open a non-existing repository" do
    # TODO: generate temporary directory
    weird_directory = "dfgdkflgjdlkgjsdlkfjsdglkjsd"
    raise "#{weird_directory} is not weird enough - ie, it exists" if Dir.exists?(weird_directory)
    expect_raises(Exception, "Couldn't open repository at #{weird_directory}") {
      Git::Repository.open(weird_directory)
    }
  end
end
