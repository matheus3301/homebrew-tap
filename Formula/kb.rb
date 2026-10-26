# frozen_string_literal: true

# Install kb from its checksummed release source.
class Kb < Formula
  desc "Local Markdown Knowledge Base for humans and AI agents"
  homepage "https://github.com/matheus3301/kb"
  url "https://github.com/matheus3301/kb/releases/download/v0.4.0/kb_0.4.0_source.tar.gz"
  sha256 "e6922506ac0afdd5373970c66c848741948fb9e66c55f9d72d46a46946ab1f0b"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOWORK"] = "off"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-s -w -X main.version=v#{version} -X main.commit=74f0d196408c1354899802e18ce569b0eab33adf"
    system "go", "build", *std_go_args(ldflags:), "./cmd/kb"
    pkgshare.install "docs", "skills", "assets", "schemas", "llms.txt", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kb version --json")
    system bin/"kb", "--root", testpath/"knowledge", "init", "--para", "--json"
    system bin/"kb", "--root", testpath/"knowledge", "validate", "--profile", "okf", "--json"
  end
end
