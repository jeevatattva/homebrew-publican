class Tageditor < Formula
  desc "Tag editor supporting MP4/M4A/AAC (iTunes), ID3, Vorbis, Opus, FLAC and Matroska"
  homepage "https://github.com/Martchus/tageditor"
  url "https://github.com/Martchus/tageditor/archive/v2.2.4.tar.gz"
  sha256 "b6086c56fde764abebcd39bf050fae60d335f0317336dc0e18ac2c944df4a7a7"

  depends_on "cmake" => :build
  depends_on "cppunit" => :build
  depends_on "openssl"

  resource "cpp-utilities" do
    url "https://github.com/Martchus/cpp-utilities.git",
  end

  resource "tagparser" do
    url "https://github.com/Martchus/tagparser.git"
  end

  def install
    resource("cpp-utilities").stage do 
      args = std_cmake_args + %W[ 
        -DCMAKE_CXX_FLAGS="-std=c++1z"
        -DCMAKE_INSTALL_PREFIX:PATH=#{libexec}/vendor
      ]

      mkdir "build" do 
        system "cmake", "..", *args
        system "make", "install"
      end
    end

    resource("tagparser").stage do
      args = std_cmake_args + %W[
        -DCMAKE_CXX_FLAGS="-std=c++1z"
        -DCMAKE_INSTALL_PREFIX:PATH=#{libexec}/vendor
        -Dc++utilities_DIR=#{libexec}/vendor/share/cmake
      ]

      mkdir "build" do 
        system "cmake", "..", *args
        system "make", "install"
      end
    end

    args = std_cmake_args + %W[
      -DCMAKE_CXX_FLAGS="-std=c++1z"
      -DWIDGETS_GUI=OFF
      -DQUICK_GUI=OFF
      -DCMAKE_PREFIX_PATH=#{libexec}/vendor
      -DCMAKE_INSTALL_PREFIX:PATH=#{prefix}
    ]

    mkdir "build" do 
      system "cmake", "..", *args
      system "make", "install" #, "DESTDIR=#{prefix}"
    end
  end

  test do
    system "true"
  end
end
