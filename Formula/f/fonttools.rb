class Fonttools < Formula
  desc "Library for manipulating fonts"
  homepage "https://github.com/fonttools/fonttools"
  url "https://files.pythonhosted.org/packages/52/c0/b117fe560be1c7bf889e341d1437c207dace4380b10c14f9c7a047df945b/fonttools-4.49.0.tar.gz"
  sha256 "ebf46e7f01b7af7861310417d7c49591a85d99146fc23a5ba82fdb28af156321"
  license "MIT"
  head "https://github.com/fonttools/fonttools.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a11bd11287cfd56866dd185e01747cf554be5002fcabca42ab7bd67503602a8d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cafeeb86976bd7f841d738b066ed24692b974bb2f51be6cf58fcf2262808198f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2eea44bf0da90b2a654e642af9093663245c90ce87069ddf72d27db6ed5fb249"
    sha256 cellar: :any_skip_relocation, sonoma:         "47c293ccb869f0257fb4565eae1dec585b52a3f92b672b9cc42ba041d0d353f8"
    sha256 cellar: :any_skip_relocation, ventura:        "bdf47273ec90e74edeabcf838b5875e61fea676422801e99fb6cf4c02dcd0fa2"
    sha256 cellar: :any_skip_relocation, monterey:       "5a252608a7e24b4833cfc9af49e30c5288306dec29658638151c666637d1f5f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e94b8b7526aa66af2f4b36ecc7e440c5806357fd8fa3c5868dc948597c77f545"
  end

  depends_on "python-setuptools" => :build
  depends_on "python-brotli"
  depends_on "python@3.12"

  def python3
    which("python3.12")
  end

  def install
    system python3, "-m", "pip", "install", *std_pip_args, "."
  end

  test do
    if OS.mac?
      cp "/System/Library/Fonts/ZapfDingbats.ttf", testpath

      system bin/"ttx", "ZapfDingbats.ttf"
      assert_predicate testpath/"ZapfDingbats.ttx", :exist?
      system bin/"fonttools", "ttLib.woff2", "compress", "ZapfDingbats.ttf"
      assert_predicate testpath/"ZapfDingbats.woff2", :exist?
    else
      assert_match "usage", shell_output("#{bin}/ttx -h")
    end
  end
end
