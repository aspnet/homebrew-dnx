require "formula"

class Kvm < Formula
  homepage "https://www.github.com/aspnet/Home"
  version "1.0.0-alpha3-10141"
  url "https://github.com/aspnet/kvm.git", :branch => 'feature-homebrew'

  depends_on "kmono" => :recommended

  def install
    libexec.install "src/kvm.sh"
    (libexec + "kvm.sh").chmod 0755
    (libexec + "mono").make_symlink "../../../kmono/3.6.1/bin/mono"
    system "bash -c 'source #{libexec}/kvm.sh; kvm upgrade'"
    bin.install_symlink "#{libexec}/kvm.sh"
    bin.install_symlink "#{libexec}/current/k"
    bin.install_symlink "#{libexec}/current/klr"
    bin.install_symlink "#{libexec}/current/kpm"
  end

end
