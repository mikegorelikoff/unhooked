#!/bin/sh
# Installs the hx binary from a GitHub release of mikegorelikoff/unhooked.
#
#   curl -fsSL https://github.com/mikegorelikoff/unhooked/releases/download/v0.1.0-preview.1/install.sh | sh
#
# Environment:
#   HX_VERSION      release tag to install (default: v0.1.0-preview.1)
#   HX_INSTALL_DIR  where to put hx (default: ~/.local/bin)
#   HX_BASE_URL     releases URL (default: https://github.com/mikegorelikoff/unhooked/releases)
#
# The archive is checked against the release's SHA256SUMS before anything is
# installed. No root is needed.
set -eu

REPO="mikegorelikoff/unhooked"
BASE="${HX_BASE_URL:-https://github.com/$REPO/releases}"
VERSION="${HX_VERSION:-v0.1.0-preview.1}"
DEST="${HX_INSTALL_DIR:-${HOME:-.}/.local/bin}"

say() { printf '%s\n' "$*" >&2; }
die() { say "install.sh: $*"; exit 1; }

detect_target() {
  os=$(uname -s)
  arch=$(uname -m)
  case "$arch" in
    x86_64 | amd64) arch=x86_64 ;;
    aarch64 | arm64) arch=aarch64 ;;
    *) die "unsupported CPU '$arch' (supported: x86_64, aarch64)" ;;
  esac
  [ "$os" = Darwin ] || die "this preview supports macOS only (found $os)"
  echo "$arch-apple-darwin"
}

if [ "${1:-}" = "--print-target" ]; then
  detect_target
  exit 0
fi

fetch() { # url, output file
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$1" -o "$2"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$1" -O "$2"
  else
    die "need curl or wget"
  fi
}

sha256_of() { # file
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$1" | awk '{print $NF}'
  else
    die "need sha256sum, shasum or openssl to verify the download"
  fi
}

target=$(detect_target)
if [ "$VERSION" = "latest" ]; then
  url="$BASE/latest/download"
else
  url="$BASE/download/$VERSION"
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT INT TERM

say "Downloading checksums ($VERSION)..."
fetch "$url/SHA256SUMS" "$tmp/SHA256SUMS" || die "cannot download $url/SHA256SUMS"

line=$(grep -- "-$target\.tar\.gz\$" "$tmp/SHA256SUMS" | head -n 1 || true)
[ -n "$line" ] || die "no build for $target in this release"
want=$(printf '%s\n' "$line" | awk '{print $1}')
file=$(printf '%s\n' "$line" | awk '{print $2}')

say "Downloading $file..."
if [ "$VERSION" = v0.1.0-preview.1 ]; then
  # This preview publishes the compressed archive in six parts per architecture.
  [ "$file" = "hx-$VERSION-$target.tar.gz" ] || die "unexpected archive name '$file'"
  : > "$tmp/$file"
  for part in aa ab ac ad ae af; do
    fetch "$url/$file.part-$part" "$tmp/part" || die "cannot download $url/$file.part-$part"
    cat "$tmp/part" >> "$tmp/$file"
  done
else
  fetch "$url/$file" "$tmp/$file" || die "cannot download $url/$file"
fi

got=$(sha256_of "$tmp/$file")
if [ "$got" != "$want" ]; then
  die "checksum mismatch for $file (expected $want, got $got); nothing was installed"
fi

tar -xzf "$tmp/$file" -C "$tmp"
bin="$tmp/${file%.tar.gz}/hx"
[ -f "$bin" ] || die "$file does not contain hx"

mkdir -p "$DEST"
cp "$bin" "$DEST/hx.new"
chmod 755 "$DEST/hx.new"
mv "$DEST/hx.new" "$DEST/hx"

say "Installed $("$DEST/hx" --version) to $DEST/hx"
case ":${PATH:-}:" in
  *":$DEST:"*) ;;
  *) say "Add $DEST to your PATH to run hx, for example: export PATH=\"$DEST:\$PATH\"" ;;
esac
