class Bcg729 < Formula
  desc "Opensource implementation of both encoder and decoder of the ITU G729 Annex A/B speech codec"
  homepage "https://www.linphone.org/technical-corner/bcg729"
  url "http://download-mirror.savannah.gnu.org/releases/linphone/plugins/sources/bcg729-1.0.0.tar.gz"
  sha256 "f7d2ff2789c132f43ac2223e418023f512474c819ef96a24fee5b75edab840cc"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-msplugin",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test bcg729`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
