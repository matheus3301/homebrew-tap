# frozen_string_literal: true

# Install kb from its checksummed release source.
class Kb < Formula
  desc "Local Markdown Knowledge Base for humans and AI agents"
  homepage "https://github.com/matheus3301/kb"
  url "https://github.com/matheus3301/kb/releases/download/v1.2.0/kb_1.2.0_source.tar.gz"
  sha256 "0b6c9f71023f8e4e8d12a0b49e3a477f13a5dd5445bfdc94723bce49cd660b69"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOWORK"] = "off"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-s -w -X main.version=v#{version} -X main.commit=a039eb5c070c70625942b340bbcc78679e88c244"
    system "go", "build", *std_go_args(ldflags:), "./cmd/kb"
    pkgshare.install "docs", "skills", "assets", "schemas", "llms.txt", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kb version --json")
    system bin/"kb", "--root", testpath/"knowledge", "init", "--para", "--json"
    system bin/"kb", "--root", testpath/"knowledge", "validate", "--profile", "okf", "--json"
  end
end
