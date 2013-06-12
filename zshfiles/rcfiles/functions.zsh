function proxy () {
	export http_proxy="www-proxy.waseda.jp:8080"
	export https_proxy="www-proxy.waseda.jp:8080"
}

function noproxy () {
	http_proxy=
	https_proxy=
	ftp_proxy=
}

# Usage: cdup pattern
# search pattern for upper directories and cd to first matched directory
# e.g. cwd: /super/very/deep/directory -> `cdup ery` -> cwd: /super/very
function cdup () {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 pattern"
		return 1
	fi

	local pat=$1
	local cwd=$PWD
	while [ $cwd != '/' ] ; do
		local dirname=${cwd##*/}
		if [[ $dirname =~ $pat ]]; then
			cd $cwd
			return 0
		fi
		cwd=${cwd%/*}
	done
	return 1
}
