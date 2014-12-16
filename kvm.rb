require "formula"

class Kvm < Formula
  homepage "https://www.github.com/aspnet/kvm"
  version "1.0.0-beta2"

  stable do
    url "https://github.com/aspnet/kvm.git", :using => :git, :tag => '1.0.0-beta2'
  end

  head do
    url "https://github.com/aspnet/kvm.git", :using => :git, :branch => 'dev'
  end

  depends_on "mono" => :recommended

  def install
    libexec.install "src/kvm.sh"
    (libexec + "kvm.sh").chmod 0755
    (libexec + "mono").make_symlink Formula["mono"].opt_bin/"mono"
    system "bash -c 'source #{libexec}/kvm.sh; kvm upgrade'"
    bin.install_symlink "#{libexec}/kvm.sh"
    bin.install_symlink "#{libexec}/current/k"
    bin.install_symlink "#{libexec}/current/klr"
    bin.install_symlink "#{libexec}/current/kpm"
  end

  def caveats; <<-EOS.undent
    Add the following to the ~/.bash_profile, ~/.bashrc or ~/.zshrc file:

      source kvm.sh

    EOS
  end
end
