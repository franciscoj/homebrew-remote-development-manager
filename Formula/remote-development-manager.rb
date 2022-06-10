# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class RemoteDevelopmentManager < Formula
  desc "Brew formula for BlakeWilliams/remote-development-manager"
  homepage "https://github.com/BlakeWilliams/remote-development-manager"
  license "Unknown"
  head "https://github.com/BlakeWilliams/remote-development-manager.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w", output: "bin/rdm")
    bin.install "bin/rdm"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test remote-development-manager`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    assert_match "A server and client for better remote development integration.", shell_output("#{bin}/rdm --help")
  end

  service do
    run [opt_bin/"rdm", "server"]
    launch_only_once true
  end
end
