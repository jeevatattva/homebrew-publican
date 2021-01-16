class YouGet < Formula
  include Language::Python::Virtualenv

  desc "Dumb downloader that scrapes the web"
  homepage "https://you-get.org/"
  url "https://files.pythonhosted.org/packages/b3/eb/e24fa3352fa27e1be3b7f8b3d158a3b12f6ee294c09614eb61b5d85fa054/you-get-0.4.1500.tar.gz"
  sha256 "5a6cc0d661fe0cd4210bf467d6c89afd8611609e402690254722c1415736da92"
  license "MIT"
  head "https://github.com/soimort/you-get.git", branch: "develop"

  livecheck do
    url :stable
  end

  depends_on "python@3.8"
  depends_on "rtmpdump"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    "To use post-processing options, run `brew install ffmpeg` or `brew install libav`."
  end

  test do
    system bin/"you-get", "--info", "https://youtu.be/he2a4xK8ctk"
  end
end
