alias mpi="mpv --profile=image"
alias mpa="mpv --profile=dontshowimage"

# play all music using mpv
alias mpv-shuffle="mpv --profile=dontshowimage --gapless-audio --playlist <(shuf <(find ~/Music -regextype posix-extended -regex \".*/*\.(mp3|wav|flac|m4a)$\"))"
