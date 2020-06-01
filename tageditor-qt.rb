class TageditorQt < Formula
  desc "Tag editor supporting MP4/M4A/AAC (iTunes), ID3, Vorbis, Opus, FLAC and Matroska"
  homepage "https://github.com/Martchus/tageditor"
  url "https://github.com/Martchus/tageditor/archive/v3.3.7.tar.gz"
  sha256 "475ddab587ab7330d147d881c7020cb4dc09b1978af87bf606d714ea21929a8d"

  depends_on "cmake" => :build
  depends_on "cppunit" => :build
  depends_on "qt"
  depends_on "openssl"
  #depends_on "rapidjson"

  resource "cpp-utilities" do
    url "https://github.com/Martchus/cpp-utilities/archive/v5.4.0.tar.gz"
    sha256 "12330ad7b3f745f91bf37193dc872462fd1e14cc13018094a200d424bf346be6"
  end

  resource "tagparser" do
    url "https://github.com/Martchus/tagparser/archive/v9.2.0.tar.gz"
    sha256 "05538d4e034f5f008f1b253b7612b6519bb98d566347045bc3b76d5a3b5a7830"
  end

  resource "qtutilities" do
    url "https://github.com/Martchus/qtutilities/archive/v6.0.6.tar.gz"
    sha256 "6e853502cc3a636d82e64f23e96050f8357f2937bca35ef3359c2ec75e8fedf3"
  end

#  resource "reflective-rapidjson" do
#    url "https://github.com/Martchus/reflective-rapidjson/archive/v0.0.14.tar.gz"
#    sha256 "647e045ac2d4d28b828256246fad815e861509ddae394bdc3e0bd53f73d0fd43"
#  end

  def install
    resource("cpp-utilities").stage do
      args = std_cmake_args + %W[
        -DCMAKE_CXX_FLAGS=-std=c++1z
        -DCMAKE_INSTALL_PREFIX:PATH=#{libexec}/vendor
      ]

      mkdir "build" do
        system "cmake", "..", *args
        system "make", "install"
      end
    end

    resource("tagparser").stage do
      args = std_cmake_args + %W[
        -DCMAKE_CXX_FLAGS=-std=c++1z
        -DCMAKE_INSTALL_PREFIX:PATH=#{libexec}/vendor
        -Dc++utilities_DIR=#{libexec}/vendor/share/cmake
      ]

      mkdir "build" do
        system "cmake", "..", *args
        system "make", "install"
      end
    end

    resource("qtutilities").stage do
      args = std_cmake_args + %W[
        -DCMAKE_CXX_FLAGS=-std=c++1z
        -DCMAKE_INSTALL_PREFIX:PATH=#{libexec}/vendor
      ]

      mkdir "build" do
        system "cmake", "..", *args
        system "make", "install"
      end
    end

#    resource("reflective-rapidjson").stage do
#      #ENV["RapidJSON_DIR"] = "#{Formula['rapidjson'].opt_prefix}"
#
#      args = std_cmake_args + %W[
#        -DCMAKE_CXX_FLAGS=-std=c++1z
#        -DCMAKE_INSTALL_PREFIX:PATH=#{libexec}/vendor
#      ]
#
#      mkdir "build" do
#        system "cmake", "..", *args
#        system "make", "install"
#      end
#    end

    args = std_cmake_args + %W[
      -DCMAKE_CXX_FLAGS=-std=c++1z
      -DCMAKE_PREFIX_PATH=#{libexec}/vendor
      -DCMAKE_INSTALL_PREFIX:PATH=#{prefix}
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
