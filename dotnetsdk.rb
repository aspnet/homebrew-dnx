require "formula"

class Dotnetsdk < Formula
  homepage "https://www.github.com/aspnet/Home"
  version "1.0.0-beta3"

  devel do
    url "https://github.com/aspnet/Home.git", :branch => 'dev'
  end

  stable do
    url "https://github.com/aspnet/Home.git", :branch => 'v1.0.0-beta3'
  end

  depends_on "mono" => :recommended

  def install
    libexec.install "dotnetsdk.sh"
    (libexec + "dotnetsdk.sh").chmod 0755
    (libexec + "mono").make_symlink Formula["mono"].opt_bin/"mono"
    system "bash -c 'source #{libexec}/dotnetsdk.sh; kvm upgrade'"
    bin.install_symlink "#{libexec}/dotnetsdk.sh"
  end

  def caveats; <<-EOS.undent
    Add the following to your ~/.bash_profile, ~/.bashrc or ~/.zshrc file:

      source dotnetsdk.sh

    EOS
  end
end
