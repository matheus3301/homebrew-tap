# frozen_string_literal: true

# Install kb from its checksummed release source.
class Kb < Formula
  desc "Local Markdown knowledge memory for humans and agents"
  homepage "https://github.com/matheus3301/kb"
  url "https://github.com/matheus3301/kb/releases/download/v0.1.1/kb_0.1.1_source.tar.gz"
  sha256 "f968d835b52de71c30353f5d2333ae5dd01c4a1d8dfbb0e4ce2ba500095fc388"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOWORK"] = "off"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-s -w -X main.version=v#{version} -X main.commit=9ed4f17894f094cfdb5a169aea9c147789e93de3"
    system "go", "build", *std_go_args(ldflags:), "./cmd/kb"
    pkgshare.install "docs", "skills", "assets", "schemas", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kb version --json")
    system bin/"kb", "--root", testpath/"knowledge", "init", "--para", "--json"
    system bin/"kb", "--root", testpath/"knowledge", "validate", "--profile", "okf", "--json"
  end
end
