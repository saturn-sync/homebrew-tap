class Saturn < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/saturn-sync/saturn"
  url "https://codeberg.org/saturn-sync/saturn/archive/v0.41.8.tar.gz"
  sha256 "53f8947a931fbb8d1db28634930c9e9bf3285e9dea2ddde3343dca68aeb87c2a"
  license "AGPL-3.0"
  head "https://codeberg.org/saturn-sync/saturn.git", branch: "main"
  version "0.41.8"

  depends_on "go" => :build

  def install
    semver = build.head? ? "0.0.0-dev" : version
    date_time = time.strftime('%Y-%m-%dT%H:%M:%SZ')

    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    system "make", "VERSION=v#{semver}", "build"
    bin.install "saturn"
    bash_completion.install "completion/saturn.bash" => "saturn"
    zsh_completion.install "completion/saturn.zsh" => "_saturn"
  end

  test do
    system "#{bin}/saturn", "version"
  end
end
