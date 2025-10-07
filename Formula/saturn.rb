class Saturn < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/saturn-sync/saturn"
  url "https://codeberg.org/saturn-sync/saturn/archive/v0.41.5.tar.gz"
  sha256 "208df13dc16b3ca2126ac152f218665cb3d49a32c392ffffd4277eaeb1749fea"
  license "AGPL-3.0"
  head "https://codeberg.org/saturn-sync/saturn.git", branch: "main"
  version "0.41.5"

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
