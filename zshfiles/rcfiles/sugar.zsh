# prevent silent overwriting
alias mv="mv -i"

alias ls="ls --color=auto --classify"
alias l="ls"
alias la="ls -a"

# Make find and ag follow symlinks
alias find="find -L"
alias ag="ag --follow"

alias ax="atool -x"
alias hist="fc -liD 1"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias sz="source $HOME/.zshenv && source $HOME/.zshrc"
alias pass="EDITOR=nano pass"

# use radeon only when necessary
alias radeon="DRI_PRIME=1 VDPAU_DRIVER=r600 LIBVA_DRIVER_NAME=vdpau"

# use Tamil if needed
alias tamil="LANG=ta_IN.UTF-8 LC_ALL=ta_IN.UTF-8"

function mkcd () {
	mkdir -p "$@" && eval cd "\"\$$#\""
}

alias org="tmux rename-window org; ORGMODE=1 emacs ~/org/dashboard.org"
alias pbs="pbsearch"

# ==================================================
# Global aliases
# ==================================================
alias -g G="| grep -i"
alias -g V="| grep -v"
alias -g A="| awk"
alias -g S="| sed"
alias -g T="| tee"
alias -g X="| xargs_with_alias"
alias -g L="| extract_line"
alias -g P="| peco"
alias -g PB="| reattach-to-user-namespace pbcopy"
alias -g PAGER="| $PAGER"

# output modification
alias -g CHOP='| awk "length < 1024 { print }"'

# ==================================================
# Tmux related
# ==================================================
alias ms="mux start"
alias mo="mux open"

# ==================================================
# Platform specific
# ==================================================
if is_mac; then
	alias x="open"

	# This is a charm
	# http://d.hatena.ne.jp/edvakf/20080929/1222657230
	alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

	# Unzip which can extract fxcking Japanese zip
	alias junzip='/usr/local/bin/unzip -Ocp932'

	# Brew
	alias b="brew"
	alias bu="brew update"
	alias bs="brew search"
	function bi() {
		if [ $# -gt 0 ]; then
			brew install $*
		else
			last_command=$history[$[HISTCMD-1]]
			last_command_array=("${(s/ /)last_command}")
			if [ "$last_command_array[1]" = "bs" ]; then
				brew install $last_command_array[-1]
			else
				brew install
			fi
		fi
	}
	alias bcs="brew cask search"
	function bci() {
		if [ $# -gt 0 ]; then
			brew cask install $*
		else
			last_command=$history[$[HISTCMD-1]]
			last_command_array=("${(s/ /)last_command}")
			if [ "$last_command_array[1]" = "bcs" ]; then
				brew cask install $last_command_array[-1]
			else
				brew cask install
			fi
		fi
	}
	alias bdr="cd $(brew --repository)"
	alias bdc="cd $(brew --cellar)"

	# Karabiner
	alias karabiner="/Applications/Karabiner.app/Contents/Library/bin/karabiner"
fi
