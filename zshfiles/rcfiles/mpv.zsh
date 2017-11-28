alias mpi="mpv --profile=image"
alias mpa="mpv --profile=dontshowimage"

# play all music using mpv
alias mpv-shuffle="mpv --profile=dontshowimage --gapless-audio --playlist <(shuf <(find ~/Music -regextype posix-extended -regex \".*/*\.(mp3|wav|flac|m4a)$\"))"
# use a specific profile when using dedicated graphics
alias rmpv="radeon mpv --profile=radeon"
alias rmpvl="radeon mpv --profile=radeon,lowbw"
alias rmpvby="radeon mpv --profile=radeon,geo-bypass-in"
alias rmpvbyl="radeon mpv --profile=radeon,geo-bypass-in,lowbw"
alias dmpv="EGL_PLATFORM=0x31D7 mpv --opengl-backend=drm"
