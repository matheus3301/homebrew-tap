# typed: false
# frozen_string_literal: true

class Loopforge < Formula
  desc "Autonomous coding loops CLI - Orchestrate AI coding agents in iterative, PRD-driven development cycles"
  homepage "https://github.com/matheus3301/loopforge"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/matheus3301/loopforge/releases/download/v0.1.0/loopforge_0.1.0_darwin_amd64.tar.gz"
      sha256 "ae5ef4a95bc8ba0330651b986751f0d67bba974146fc4065902b899e3a1416eb"
    end
    on_arm do
      url "https://github.com/matheus3301/loopforge/releases/download/v0.1.0/loopforge_0.1.0_darwin_arm64.tar.gz"
      sha256 "884d932230aff49802d328eac92979cd46e164c3b96786f1e997cfb7facde36e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/matheus3301/loopforge/releases/download/v0.1.0/loopforge_0.1.0_linux_amd64.tar.gz"
      sha256 "11d52c7e7a616d0ff4644adbc44156418df5f21bbe3c624c4a2192d6b9fa5d36"
    end
    on_arm do
      url "https://github.com/matheus3301/loopforge/releases/download/v0.1.0/loopforge_0.1.0_linux_arm64.tar.gz"
      sha256 "a0bbc7b1ce8fe86d44e3049ccf3764cf6be1e734961c7b6b86daa50bee34f2f8"
    end
  end

  def install
    bin.install "loopforge"
  end

  test do
    system "#{bin}/loopforge", "--version"
  end
end
