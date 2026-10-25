# frozen_string_literal: true

# Install kb from its checksummed release source.
class Kb < Formula
  desc "Local Markdown Knowledge Base for humans and AI agents"
  homepage "https://github.com/matheus3301/kb"
  url "https://github.com/matheus3301/kb/releases/download/v0.3.1/kb_0.3.1_source.tar.gz"
  sha256 "520939ed0d841d1f7faedc1f52df7c9f64d6f2e05fb7dd8ae85de2587550e2bc"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOWORK"] = "off"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-s -w -X main.version=v#{version} -X main.commit=2ca104f48cc4a6551f4bbc4fae12d51432e42dff"
    system "go", "build", *std_go_args(ldflags:), "./cmd/kb"
    pkgshare.install "docs", "skills", "assets", "schemas", "llms.txt", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kb version --json")
    system bin/"kb", "--root", testpath/"knowledge", "init", "--para", "--json"
    system bin/"kb", "--root", testpath/"knowledge", "validate", "--profile", "okf", "--json"
  end
end
