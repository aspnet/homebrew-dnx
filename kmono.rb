require "formula"

class Kmono < Formula
  homepage "http://www.mono-project.com/"
  url "https://github.com/mono/mono.git", :revision => 'd795d17c3d853f3d70dea416588a5e338c4c128e'
  version "3.6.1"

  bottle do
    root_url "https://github.com/aspnet/homebrew-k/releases/download/v1.0.0-alpha3-10141"
    sha1 "36ce327e4587f747c6af5bc9c6c45c44634d956b" => :mavericks
  end

  resource "monolite" do
    url "http://storage.bos.xamarin.com/mono-dist-master/latest/monolite-111-latest.tar.gz"
    sha1 "af90068351895082f03fdaf2840b7539e23e3f32"
  end

  # This file is missing in the 3.4.0 tarball as of 2014-05-14...
  # See https://bugzilla.xamarin.com/show_bug.cgi?id=18690
  resource "Microsoft.Portable.Common.targets" do
    url "https://raw.githubusercontent.com/mono/mono/mono-3.4.0/mcs/tools/xbuild/targets/Microsoft.Portable.Common.targets"
    sha1 "7624c3f6d1e4867da2e217ba0d1595a224971e27"
  end

  # help mono find its MonoPosixHelper lib when it is not in a system path
  # see https://bugzilla.xamarin.com/show_bug.cgi?id=18555
#  patch do
#    url "https://bugzilla.xamarin.com/attachment.cgi?id=6399"
#    sha1 "d011dc55f341feea0bdb8aa645688b815910b734"
#  end

  depends_on :autoconf
  depends_on :automake
  depends_on :libtool

  def install
    # a working mono is required for the the build - monolite is enough
    # for the job
    (buildpath+"mcs/class/lib/monolite").install resource("monolite")

    args = %W[
      --prefix=#{prefix}
      --enable-nls=no
    ]
    args << "--build=" + (MacOS.prefer_64_bit? ? "x86_64": "i686") + "-apple-darwin"

    system "./autogen.sh", *args
    system "make"

    # TODO: Remove once the updated 3.4.0 tarball gets built.
    (buildpath+"mcs/tools/xbuild/targets").install resource("Microsoft.Portable.Common.targets")

    system "make", "install"
    # mono-gdb.py and mono-sgen-gdb.py are meant to be loaded by gdb, not to be
    # run directly, so we move them out of bin
    libexec.install bin/"mono-gdb.py", bin/"mono-sgen-gdb.py"
  end

  test do
    test_str = "Hello Homebrew"
    hello = (testpath/"hello.cs")
    hello.write <<-EOS.undent
      public class Hello1
      {
         public static void Main()
         {
            System.Console.WriteLine("#{test_str}");
         }
      }
    EOS
    `#{bin}/mcs #{hello}`
    assert $?.success?
    output = `#{bin}/mono hello.exe`
    assert $?.success?
    assert_equal test_str, output.strip
  end

  def caveats; <<-EOS.undent
    To use the assemblies from other formulae you need to set:
      export MONO_GAC_PREFIX="#{HOMEBREW_PREFIX}"
    EOS
  end
end
