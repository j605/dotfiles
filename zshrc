# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/genki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ==================================================
# Environment Variables
# ==================================================
export HTTP_HOME=http://vim.wikia.com/wiki/Special:Random
export TERM=xterm-256color

export MYBUNDLES=$HOME/dotfiles/.mybundles

# ==================================================
# oh-my-zsh
# ==================================================
# Path to your oh-my-zsh configuration.
export ZSH=$MYBUNDLES/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="genki"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ==================================================
# dircolors-solarized
# ==================================================
eval `dircolors $MYBUNDLES/dircolors-solarized/dircolors.256dark`

# ==================================================
# PATH setting
# ==================================================
function add_path() {
	echo $PATH | grep -bo "$1\(:\|$\)" &> /dev/null
	if [ $? -ne 0 ]; then
		PATH=$PATH:$1
	fi
}

# Add: path to texlive
add_path "/usr/local/texlive/2011/bin/i386-linux"

# Add RVM to PATH for scripting
add_path "$HOME/.rvm/bin"

# Source rvm environment
which rails &> /dev/null
if [ $? -ne 0 ]; then
	source $HOME/.rvm/environments/default
fi

# ==================================================
# Aliases
# ==================================================
alias vim="vim --servername genki" # in order to use AsyncCommand
alias hist="fc -liD 1"
alias ack="ack-grep"

alias ev="vim ~/dotfiles/vimrc"
alias ez="vim ~/dotfiles/zshrc"
alias et="vim ~/dotfiles/tmux.conf"
alias neobundle="vim -u $HOME/dotfiles/bundle_vimrc"

# ==================================================
# Functions
# ==================================================
function clear() { echo "Don't bother to type \"clear\"! Just use <C-L>." }
function touch() { echo "Don't bother to type \"touch\"! Just use \"> filename\"." }

# ==================================================
# Linux 101 Hacks
# ==================================================
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
# cd -
# dirs, pushd, popd
# shopt -s cdspell (not for zsh)

# ==================================================
# History settings
# ==================================================
setopt EXTENDED_HISTORY

# ==================================================
# Tmux
# ==================================================
# auto launch
ps -e | grep tmux &> /dev/null
if [ $? -ne 0 ]; then
	if which tmux &> /dev/null; then
		tmux
	else
		echo "tmux not installed. pity..."
	fi
fi

function tmuxpwd() {
	if [ -n "$TMUX" ]; then
		tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD"
	fi
}
precmd_functions=($precmd_functions tmuxpwd)

# ==================================================
# Miscellaneous
# ==================================================
# RescueTime
ps -e | grep rescuetime &> /dev/null
if [ $? -ne 0 ]; then
	if which rescuetime &> /dev/null; then
		screen -d -m rescuetime
	else
		echo "You should install RescueTime, really."
	fi
fi

# PomodoroApp
if [ -x ~/PomodoroApp/PomodoroApp ]; then
	if [ ! -L ~/.local/share/data/PomodoroApp/PomodoroApp.db ]; then
		echo "You want to share PomodoroApp.db with Dropbox or something."
	else
		ps -e | grep PomodoroApp &> /dev/null
		if [ $? -ne 0 ]; then
			echo -n "Invoke PomodoroApp? [y/n]: "
			read CONFIRM
			case $CONFIRM in
				y|Y|YES|yes|Yes) screen -d -m ~/PomodoroApp/PomodoroApp ;;
				*)
			esac
		fi
	fi
else
	echo "You should install PomodoroApp, really."
fi

# AutoJump
if [ -f /usr/share/autojump/autojump.zsh ]; then
	source /usr/share/autojump/autojump.zsh
else
	echo "You should install autojump, really."
fi

