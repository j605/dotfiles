" ==================================================
" My vimrc (in '~/.vim/vimrc/')
" ==================================================

" Vim Settings
" .vim/vimrc/settings.vim

" Vim Mappings
" .vim/vimrc/mappings.vim

" Vim Syntax
" .vim/vimrc/syntax.vim

" Vim Plugin Settings
" .vim/vimrc/plugins.vim

for f in split(glob('~/.vim/vimrc/*.vim'), '\n')
	execute 'source' f
endfor


" ==================================================
" NeoBundle
" ==================================================

" use NeoBundle
set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/.bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/.bundle'))
endif

" --------------------------------------------------
" Common
" --------------------------------------------------

" Vim plugins management
NeoBundle 'Shougo/neobundle.vim.git'

" Acceleration of Vim functionalities
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'YankRing.vim'

" Programming Features
NeoBundle 'vim-scripts/SingleCompile.git'
NeoBundleLazy 'thinca/vim-quickrun.git'
NeoBundleLazy 'ujihisa/quicklearn.git'

" Integration with outer softwares
NeoBundle 'tpope/vim-fugitive.git'

" Visual
NeoBundle 'altercation/vim-colors-solarized'
syntax enable
set t_Co=16
set background=dark
colorscheme solarized

" Other Utilities
NeoBundleLazy 'fuenor/qfixhowm.git'
NeoBundle 'h1mesuke/unite-outline'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------

" TeX
NeoBundleLazy 'gerw/vim-latex-suite.git'

" Sourcings
autocmd FileType tex call SourceTexPlugins()
function! SourceTexPlugins()
	NeoBundleSource vim-latex-suite
endfunction

filetype plugin on
filetype indent on

