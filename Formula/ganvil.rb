class Ganvil < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/ganvil/ganvil"
  url "https://codeberg.org/ganvil/ganvil/archive/v0.34.1.tar.gz"
  sha256 "d4e8793ce21d9a6d5b26a730f08c0100de93a6f591676e575a31fe3b780abcaf"
  license "AGPL-3.0"
  head "https://codeberg.org/ganvil/ganvil.git", branch: "main"
  version "0.34.1"

  depends_on "go" => :build

  def install
    semver = build.head? ? "0.0.0-dev" : version
    date_time = time.strftime('%Y-%m-%dT%H:%M:%SZ')

    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    system "make", "VERSION=v#{semver}", "VERSION_DATETIME=#{date_time}", "VERSION_HASH=", "build"
    bin.install "ganvil"
    bash_completion.install "completion/ganvil.bash" => "ganvil"
    zsh_completion.install "completion/ganvil.zsh" => "_ganvil"
  end

  test do
    system "#{bin}/ganvil", "version"
  end
end
