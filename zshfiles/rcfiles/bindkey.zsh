autoload edit-command-line
zle -N edit-command-line
bindkey '^@' edit-command-line

# ==================================================
# My widgets
# ==================================================
# Mark all widgets for autoloading and
# Register zle widgets
for wgt in $WIDGETDIR/*
do
	autoload -U $wgt:t
	zle -N $wgt:t
done

bindkey '//' global-expansion-home-dir
# I mean '^/'. Only on mac?
bindkey '^_' global-expansion-marked-dir

# Tip: press <C-v><key> to get <key>'s keycode