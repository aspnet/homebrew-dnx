require "formula"

class Kre < Formula
  homepage "https://www.github.com/aspnet/Home"
  version "1.0.0-alpha3-10141"
  url "https://github.com/aspnet/homebrew-k/releases/download/v1.0.0-alpha3-10141/KRE-mono45-x86-1.0.0-alpha3.10141.nupkg"
  sha1 "c497f449bb7496dc7e2d41f248f83259b6d4313c"

  depends_on "kmono" => :recommended

  def install
    libexec.install Dir["bin/*"]
    (libexec + "klr").chmod 0755
    (libexec + "kpm").chmod 0755
    (libexec + "k").chmod 0755
    (libexec + "mono").make_symlink "../../../kmono/3.6.1/bin/mono"
    bin.install_symlink "#{libexec}/klr"
    bin.install_symlink "#{libexec}/kpm"
    bin.install_symlink "#{libexec}/k"
  end

end
