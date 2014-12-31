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
let g:LatexBox_latexmk_options="-pdf"
let g:LatexBox_viewer="zathura"
