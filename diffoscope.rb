class Diffoscope < Formula
  include Language::Python::Virtualenv

  desc "In-depth comparison of files, archives, and directories"
  homepage "https://diffoscope.org"
  url "https://files.pythonhosted.org/packages/47/19/c28e4ddd0ebf5601725939b74b6aa1463523ef65e8e0753c695ced871155/diffoscope-160.tar.gz"
  sha256 "f164b5e74cc11f6238ad8d62c92d3a819fa4c8b618683fc0533e04f21acae6b2"

  depends_on "cmake" => :build
  depends_on "gnu-tar"
  depends_on "libarchive"
  depends_on "libmagic"
  depends_on "python@3.9"

  # required for fuzzy matching
  resource "tlsh" do
    url "https://github.com/trendmicro/tlsh/archive/4.2.1.tar.gz"
    sha256 "ef90e81a5a400a7bc3074f126c133b88f19820a09ead8d457c2aacd4669178ba"
  end

  # required by cmdline
  resource "argcomplete" do
    url "https://files.pythonhosted.org/packages/43/61/345856864a72ccc004bea5f74183c58bfd6675f9eab931ff9ce21a8fe06b/argcomplete-1.11.1.tar.gz"
    sha256 "5ae7b601be17bf38a749ec06aa07fb04e7b6b5fc17906948dc1866e7facf3740"
  end

  resource "libarchive-c" do
    url "https://files.pythonhosted.org/packages/63/fe/9e6c78db381934e28c7ec3d30d4f209fe24442d17f1bd8c56d13ae185cf6/libarchive-c-2.9.tar.gz"
    sha256 "9919344cec203f5db6596a29b5bc26b07ba9662925a05e24980b84709232ef60"
  end

  # required by cmdline
  resource "progressbar" do
    url "https://files.pythonhosted.org/packages/a3/a6/b8e451f6cff1c99b4747a2f7235aa904d2d49e8e1464e0b798272aa84358/progressbar-2.5.tar.gz"
    sha256 "5d81cb529da2e223b53962afd6c8ca0f05c6670e40309a7219eacc36af9b6c63"
  end

  resource "python-magic" do
    url "https://files.pythonhosted.org/packages/e3/85/1aff76b966622868a73717abd8b501a3c91890e23a65e5f574ff6df1970f/python-magic-0.4.18.tar.gz"
    sha256 "b757db2a5289ea3f1ced9e60f072965243ea43a2221430048fd8cacab17be0ce"
  end

  def install
    venv = virtualenv_create(libexec, Formula["python@3.9"].opt_bin/"python3")
    %w[python-magic progressbar argcomplete libarchive-c].each do |resource|
      venv.pip_install resource
      venv.pip_install buildpath
    end

    resource("tlsh").stage do
      system "./make.sh"
      cd "py_ext" do
        system "python3.9", "setup.py", "build"
        system "python3.9", "setup.py", "install", "--prefix", "#{HOMEBREW_PREFIX}/Cellar/diffoscope/#{version}/libexec"
      end
    end

    bin.install libexec/"bin/diffoscope"
    libarchive = Formula["libarchive"].opt_lib/"libarchive.dylib"
    bin.env_script_all_files(libexec/"bin", :LIBARCHIVE => libarchive)
  end

  test do
    (testpath/"test1").write "test"
    cp testpath/"test1", testpath/"test2"
    system "#{bin}/diffoscope", "--progress", "test1", "test2"
  end
end
