require "formula"

class Kvm < Formula
  homepage "https://www.github.com/aspnet/Home"
  version "1.0.0-beta2"

  url "https://github.com/aspnet/Home.git", :tag => 'v1.0.0-beta2'

  depends_on "mono" => :recommended

  def install
    onoe "The 'kvm' tool has been deprecated. Install 'dotnetsdk' for the latest versions of the .NET Cross-Platform SDK"
    onoe "Run the following commands:"
    onoe " > brew remove kvm"
    onoe " > brew install dotnetsdk"
    onoe "Then update your ~/.bashrc, ~/.bash_profile, and ~/.zshrc files as needed"
    onoe "See https://github.com/aspnet/Home for more info!"
  end
end
