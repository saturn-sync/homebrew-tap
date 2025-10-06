#!/usr/bin/env bash

set -euo pipefail

version=${1-""}
if [[ -z "${version}" ]]; then
  release_url="https://codeberg.org/api/v1/repos/saturn-sync/saturn/releases/latest"
  version=$(curl -fsSL "${release_url}" | jq -r '.name')
fi
version=${version#"v"}

archive_url="https://codeberg.org/saturn-sync/saturn/archive/v${version}.tar.gz"
sha256=$(curl -fsSL "${archive_url}" | sha256sum | cut -d ' ' -f 1)

mkdir -p ./Formula

cat <<EOF > ./Formula/saturn.rb
class Saturn < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/saturn-sync/saturn"
  url "${archive_url}"
  sha256 "${sha256}"
  license "AGPL-3.0"
  head "https://codeberg.org/saturn-sync/saturn.git", branch: "main"
  version "${version}"

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
EOF
