# save all commands into log file
function save_command() {
	if [ "$(id -u)" -ne 0 ]; then
		FULL_CMD_LOG="$HOME/.zhistlogs/zsh-history-$(date -u "+%Y-%m-%d").log"
		echo "$USER@`hostname`:`pwd` [$(date -u)] `\history -1`" >> ${FULL_CMD_LOG}
	fi
}
precmd_functions=($precmd_functions save_command)

# overwrite oh-my-zsh to enjoy huffshell
setopt no_hist_expire_dups_first
setopt no_hist_ignore_dups
setopt no_share_history
