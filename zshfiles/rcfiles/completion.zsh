# Suppress cwd from cd completion
zstyle ':completion:*' ignore-parents parent pwd ..
# Use LS_COLORS during tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Add extra file-patterns for mpv
zstyle ':completion:*:*:mpv:*' file-patterns '*.(#i)(aac|m4a|wma)(-.) %p:globbed-files *(-/):directories' '*:all-files'
