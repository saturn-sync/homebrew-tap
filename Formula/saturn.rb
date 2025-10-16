class Saturn < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/saturn-sync/saturn"
  url "https://codeberg.org/saturn-sync/saturn/archive/v0.43.0.tar.gz"
  sha256 "54517cf2fb02302c1e7b994d5d53045d66b3c80d5be8c5d9d5b9b98d37cf49b7"
  license "AGPL-3.0"
  head "https://codeberg.org/saturn-sync/saturn.git", branch: "main"
  version "0.43.0"

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
