class Saturn < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/saturn-sync/saturn"
  url "https://codeberg.org/saturn-sync/saturn/archive/v0.41.10.tar.gz"
  sha256 "88f26ab981d5ce5420ee61009630d83a19c22919a1fd1bd4e538aa1b8a89f3e0"
  license "AGPL-3.0"
  head "https://codeberg.org/saturn-sync/saturn.git", branch: "main"
  version "0.41.10"

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
