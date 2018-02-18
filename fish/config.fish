#{{{ Options
# disable greeting
set fish_greeting
#}}}

#{{{ Non autoload funtions
# wrap pass to use nano as editor
function pass --wraps=pass
  env EDITOR=nano pass $argv
end

function rmpv --wraps=mpv --description="mpv with radeon hwdec (X)"
  env MESA_GL_VERSION_OVERRIDE=4.1 MESA_GLSL_VERSION_OVERRIDE=410 DRI_PRIME=1 \
    VDPAU_DRIVER=r600 LIBVA_DRIVER_NAME=vdpau \
    mpv --profile=radeon_x11 $argv
end

function wrmpv --wraps=mpv --description="mpv with radeon hwdec (wayland)"
  env MESA_GL_VERSION_OVERRIDE=4.1 MESA_GLSL_VERSION_OVERRIDE=410 DRI_PRIME=1 \
    VDPAU_DRIVER=r600 LIBVA_DRIVER_NAME=vdpau \
    mpv --profile=radeon_wayland $argv
end

function wrmpv_dbg --wraps=mpv --description="mpv with radeon hwdec (wayland debug)"
  env WAYLAND_DEBUG=client MESA_GL_VERSION_OVERRIDE=4.1 MESA_GLSL_VERSION_OVERRIDE=410 DRI_PRIME=1 \
    VDPAU_DRIVER=r600 LIBVA_DRIVER_NAME=vdpau \
    mpv --profile=radeon_wayland $argv
end

function mpv-shuffle --description="shuffle and play all songs in a given folder or default to ~/Music"
  set -l music_folder "$HOME/Music"
  if count $argv > /dev/null
    set music_folder $argv[1]
  end

  mpv --profile=dontshowimage --gapless-audio --playlist (shuf (find $music_folder \
  -regextype posix-extended -regex ".*/*\.(mp3|wav|flac|m4a)\$" | psub) | psub)
end

#}}}
