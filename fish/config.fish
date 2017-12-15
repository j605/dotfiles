#{{{ Options
# disable greeting
set fish_greeting
#}}}

#{{{ Non autoload funtions
# wrap pass to use nano as editor
function pass --wraps=pass
  env EDITOR=nano pass $argv
end

#}}}
