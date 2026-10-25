# frozen_string_literal: true

# Install kb from its checksummed release source.
class Kb < Formula
  desc "Local Markdown knowledge memory for humans and agents"
  homepage "https://github.com/matheus3301/kb"
  url "https://github.com/matheus3301/kb/releases/download/v0.1.2/kb_0.1.2_source.tar.gz"
  sha256 "03bb6230def7eed8aa7763f4bd4d2354deb3393816c904dcec03db902993d32f"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOWORK"] = "off"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-s -w -X main.version=v#{version} -X main.commit=ca73aed8603267d02a382a501930b6054addad66"
    system "go", "build", *std_go_args(ldflags:), "./cmd/kb"
    pkgshare.install "docs", "skills", "assets", "schemas", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kb version --json")
    system bin/"kb", "--root", testpath/"knowledge", "init", "--para", "--json"
    system bin/"kb", "--root", testpath/"knowledge", "validate", "--profile", "okf", "--json"
  end
end
