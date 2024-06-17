#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/crossplane/crossplane"
TOOL_NAME="crossplane"
TOOL_TEST="crossplane -h"

fail() {
	echo -e "mise-$TOOL_NAME: $*"
	exit 1
}

unsupported_arch() {
  local os=$1
  local arch=$2
  fail "Crossplane does not support ${os} / ${arch} at this time."
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  curl "${curl_opts[@]}" 'https://s3-us-west-2.amazonaws.com/crossplane.releases?delimiter=/&prefix=stable/' |
    grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+' |
    sed 's/v//g'
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	os=$(uname -s)
	arch=$(uname -m)
	OS_ARCH=""

	BIN=${BIN:-crank}

	case ${os} in
		CYGWIN* | MINGW64* | Windows*)
			if [ ${arch} = "x86_64" ]
			then
				OS_ARCH=windows_amd64
				BIN=crank.exe
			else
				unsupported_arch $OS ${arch}
			fi
			;;
		Darwin)
			case ${arch} in
				x86_64|amd64)
					OS_ARCH=darwin_amd64
					;;
				arm64)
					OS_ARCH=darwin_arm64
					;;
				*)
					unsupported_arch $OS ${arch}
					;;
			esac
			;;
		Linux)
			case ${arch} in
				x86_64|amd64)
					OS_ARCH=linux_amd64
					;;
				arm64|aarch64)
					OS_ARCH=linux_arm64
					;;
				*)
					unsupported_arch $OS ${arch}
					;;
			esac
			;;
		*)
			unsupported_arch $OS ${arch}
			;;
	esac

	url="https://releases.crossplane.io/stable/v${version}/bin/${OS_ARCH}/${BIN}"
	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "${filename}" -C - "${url}" || fail "Could not download ${url}"
	chmod +x ${filename}
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "mise-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# TODO: Assert mise-crossplane-cli executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
