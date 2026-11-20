class Ncal < Formula
  desc "Agent-oriented Notion Calendar CLI"
  homepage "https://github.com/olegpustovit/ncal"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/olegpustovit/ncal/releases/download/v0.2.1/ncal-aarch64-apple-darwin.tar.xz"
      sha256 "531412b785d7a42c4c2d5ad3d86dedc497215a3bd6a8b982e8904f73d1bcf71b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/olegpustovit/ncal/releases/download/v0.2.1/ncal-x86_64-apple-darwin.tar.xz"
      sha256 "230c0dcb4bb7ae0566a6b1cb3d18c2c81310ba83d43cf58fcec4245ece07720e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/olegpustovit/ncal/releases/download/v0.2.1/ncal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d9e46f82a8c1ec10324abb4dd8ff41f00cbfbadb78c87070aadf42e6f6af6d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/olegpustovit/ncal/releases/download/v0.2.1/ncal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "213c4644612023138abbf3dd7158976acf9c937a208c930c6dfcb0247343fb66"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ncal"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ncal"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ncal"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ncal"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
