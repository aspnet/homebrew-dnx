require "formula"

class Dotnetsdk < Formula
  homepage "https://www.github.com/aspnet/Home"
  version "1.0.0-beta3"

  devel do
    url "https://github.com/aspnet/Home.git", :branch => 'dev'
  end

  stable do
    # TEMPORARY until beta3 is released and there is a formal tag for the latest version available
    url "https://github.com/aspnet/Home.git", :branch => 'release'

    # Switch this to the below once beta3 is released and the tag is made
    #url "https://github.com/aspnet/Home.git", :tag => 'v1.0.0-beta3'
  end

  depends_on "mono" => :recommended

  def install
    libexec.install "dotnetsdk.sh"
    (libexec + "dotnetsdk.sh").chmod 0755
    (libexec + "mono").make_symlink Formula["mono"].opt_bin/"mono"
    system "bash -c 'source #{libexec}/dotnetsdk.sh; dotnetsdk upgrade'"
    bin.install_symlink "#{libexec}/dotnetsdk.sh"
  end

  def caveats; <<-EOS.undent
    Add the following to your ~/.bash_profile, ~/.bashrc or ~/.zshrc file:

      source dotnetsdk.sh

    EOS
  end
end
