# Helper functions
function safe_ln () {
	src=$1
	dst=$2
	if [[ -L $dst ]]; then rm $dst; fi
	ln -s $src $dst
}

# ==================================================
# dotfiles
# ==================================================
dotfiles=(
	zshfiles/zshrc
	zshfiles/zshenv
	vimfiles/vim
	vimfiles/vimrc
	emacsfiles/emacs
	rubyfiles/pryrc
	rubyfiles/gemfiles/gemrc
	gitfiles/git_template
	gitfiles/gitignore_global
	gitfiles/gitconfig
	miscfiles/ctags
	miscfiles/latexmkrc
	miscfiles/tmux.conf
	miscfiles/vimperator
	miscfiles/vimperatorrc
)
for f in $dotfiles; do
	src=$DOTDIR/$f
	dst=$HOME/.${f##*/}
	safe_ln $src $dst
done

# ==================================================
# bin files
# ==================================================
safe_ln $HOME/dotfiles/bin/cop.rb $HOME/bin/cop

# ==================================================
# misc files
# ==================================================
safe_ln $DOTDIR/miscfiles/get-shit-done.ini $HOME/.config/get-shit-done.ini
