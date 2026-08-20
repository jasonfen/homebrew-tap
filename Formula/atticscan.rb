class Atticscan < Formula
  include Language::Python::Virtualenv

  desc "Triage old external drives on macOS: detect, identify, census important files"
  homepage "https://github.com/jasonfen/atticscan"
  url "https://github.com/jasonfen/atticscan/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d76360000cb905997394e9d055ae8638322182ad6ca9554d4f16c90581d3670c"
  license "MIT"

  depends_on :macos
  depends_on "python@3.14"

  # Optional raw-device backend (unmounted volumes, lost partitions).
  # pytsk3 builds its bundled copy of The Sleuth Kit.
  resource "pytsk3" do
    url "https://files.pythonhosted.org/packages/74/c2/3e8a2f00ffbe7024c5fd706694f85f8cc2eaaade9de2d8f220b13cb5971e/pytsk3-20260715.tar.gz"
    sha256 "50825f97cb5b9bdf3119466104d78e9bef512dd0a0ce1615aea700ad2f457b8e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/atticscan --version")
    assert_match "drives", shell_output("#{bin}/atticscan list")
  end
end
