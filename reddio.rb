class Reddio < Formula
  desc "A command-line interface for Reddit written in POSIX sh"
  homepage "https://gitlab.com/aaronNG/reddio"
  url "https://gitlab.com/aaronNG/reddio/-/archive/v0.4/reddio-v0.4.tar.bz2"
  sha256 "57f88da9a3c816c0fb23f21eaadbfac10f11a9dcebca500809ab6b6e520e4145"

  depends_on "coreutils" => :recommended
  depends_on "jq" => :recommended

  uses_from_macos "curl"

  def install
    ENV["PREFIX"] = "#{HOMEBREW_PREFIX}/Cellar/reddio/" + version.to_s
    inreplace "share/reddio/oauth.sh", "set -- -l -p", "set -- -l"
    inreplace "reddio", "chmod 600 --", "chmod 600"
    system "make", "install"
  end

  test do
    system "true"
  end
end
