require "./spec_helper"
require "Base64"
require "openssl/sha1"

describe Git do

  @@oids = [
    "d8786bfc974aaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "d8786bfc974bbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
    "d8786bfc974ccccccccccccccccccccccccccccc",
    "68d041ee999cb07c6496fbdd4f384095de6ca9e1"
  ]

  it "reports libgit2's version" do
    version = Git.version
    version.size.should eq(3)
    version.each do |i|
      i.should be_a(Int32)
    end
  end

  pending "sets libgit2's settings" do
    Git.settings["mwindow_size"] = 8 * 1024 * 1024
    Git.settings["mwindow_mapped_limit"] = 8 * 1024 * 1024

    Git.settings["mwindow_size"].should eq(8 * 1024 * 1024)

    expect_raises(TypeError) {
      Git.settings["mwindow_mapped_limit"] = "asdf"
    }

    expect_raises(TypeError) {
      Git.settings["mwindow_size"] = nil
    }
  end

  pending "sets libgit2's search path" do
    paths = [{"search_path_global", "/tmp/global"},
             {"search_path_xdg", "/tmp/xdg"},
             {"search_path_system", "/tmp/system"}]

    uno, dos = [1, "hola"]
    paths.each do |uno|
      Git.settings[opt] = path
      Git.settings[opt].should eq(path)
    end
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

  it "prettifies messages" do
    message = <<-MESSAGE
Testing this whole prettify business

with newlines and stuff
# take out this line haha
# and this one

not this one

MESSAGE

    clean_message = <<-MESSAGE
Testing this whole prettify business

with newlines and stuff

not this one

MESSAGE

    Git.prettify_message(message, true).should eq(clean_message)
  end

  it "prettifies messages with other comment chars" do
    message = <<-MESSAGE
Testing this whole prettify business

with newlines and stuff
# take out this line haha
# and this one

not this one

MESSAGE

    clean_message = <<-MESSAGE
Testing this whole prettify business

# take out this line haha
# and this one

not this one

MESSAGE

    Git.prettify_message(message, 'w').should eq(clean_message)
  end

end
