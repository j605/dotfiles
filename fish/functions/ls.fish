# This appears to be GNU ls.
function ls --description "List contents of directory (work like a FM)"
  command ls --color=auto --indicator-style=classify --group-directories-first $argv
end
