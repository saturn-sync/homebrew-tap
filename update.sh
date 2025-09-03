#!/usr/bin/env bash

set -euo pipefail

version=${1-""}
if [[ -z "${version}" ]]; then
  release_url="https://codeberg.org/api/v1/repos/ganvil/ganvil/releases/latest"
  version=$(curl -fsSL "${release_url}" | jq -r '.name')
fi
version=${version#"v"}

archive_url="https://codeberg.org/ganvil/ganvil/archive/v${version}.tar.gz"
sha256=$(curl -fsSL "${archive_url}" | sha256sum | cut -d ' ' -f 1)

mkdir -p ./Formula

cat <<EOF > ./Formula/ganvil.rb
class Ganvil < Formula
  desc "Create, modify or delete files across many repositories."
  homepage "https://codeberg.org/ganvil/ganvil"
  url "${archive_url}"
  sha256 "${sha256}"
  license "AGPL-3.0"
  head "https://codeberg.org/ganvil/ganvil.git", branch: "main"
  version "${version}"

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
EOF
