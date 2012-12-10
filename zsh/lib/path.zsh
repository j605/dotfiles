# Add path to $HOME/bin
PATH=$HOME/bin:$PATH

# texlive
PATH=/usr/local/texlive/2012/bin/i386-linux:$PATH

# RVM for scripting
PATH=$HOME/.rvm/bin:$PATH

# Remove duplications
typeset -U path cdpath manpath fpath