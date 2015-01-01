" --------------------------------------------------
" Text writing setting
" --------------------------------------------------
setlocal spell spelllang=en_gb
setlocal thesaurus+=~/.vim/resources/thesaurus/mthesaur.txt


" --------------------------------------------------
" Vim-LaTeX-Box Settings
" --------------------------------------------------
filetype plugin on
set shellslash
set grepprg=grep\-nH\$*
filetype indent on

" http://superuser.com/questions/302186/vim-scrolls-very-slow-when-a-line-is-too-long
set norelativenumber
set nocursorline
set lazyredraw
set synmaxcol=128

let g:tex_fold_enabled = 1
let g:LatexBox_latexmk_options="-pdf -shell-escape"
let g:LatexBox_viewer="zathura"
