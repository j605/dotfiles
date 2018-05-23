#{{{ Options
# disable greeting
set fish_greeting
#}}}

#{{{ Non autoload funtions
function rmpv --wraps=mpv --description="mpv with radeon hwdec (X)"
  env MESA_GL_VERSION_OVERRIDE=4.4 MESA_GLSL_VERSION_OVERRIDE=440 DRI_PRIME=1 \
    VDPAU_DRIVER=r600 \
    mpv --profile=radeon_x11 $argv
end

function rmpv_vdpau --wraps=mpv --description="mpv with radeon hwdec (X)"
  env MESA_GL_VERSION_OVERRIDE=4.4 MESA_GLSL_VERSION_OVERRIDE=440 DRI_PRIME=1 \
    VDPAU_DRIVER=r600 \
    mpv --profile=radeon_x11 --hwdec=vdpau $argv
end

function wrmpv --wraps=mpv --description="mpv with radeon hwdec (wayland)"
  env MESA_GL_VERSION_OVERRIDE=4.4 MESA_GLSL_VERSION_OVERRIDE=440 DRI_PRIME=1 \
    LIBVA_DRIVER_NAME=r600 \
    mpv --profile=radeon_wayland $argv
end

function wrmpv_dbg --wraps=mpv --description="mpv with radeon hwdec (wayland debug)"
  env WAYLAND_DEBUG=client MESA_GL_VERSION_OVERRIDE=4.4 MESA_GLSL_VERSION_OVERRIDE=440 DRI_PRIME=1 \
    LIBVA_DRIVER_NAME=r600 \
    mpv --profile=radeon_wayland $argv
end

function mpv-shuffle --description="shuffle and play all songs in a given folder or default to ~/Music"
  set -l music_folder "$HOME/Music"
  if count $argv > /dev/null
    set music_folder $argv
  end

  mpv --profile=dontshowimage --gapless-audio --playlist (shuf (find $music_folder \
  -regextype posix-extended -regex ".*/*\.(mp3|wav|flac|m4a)\$" | psub) | psub)
end

function mpi --wraps=mpv --description="mpv image viewer"
  mpv --profile=image $argv
end

#}}}

source /usr/share/autojump/autojump.fish
