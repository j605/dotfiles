" --------------------------------------------------
" Text writing setting
" --------------------------------------------------
setlocal spell spelllang=en_gb
setlocal thesaurus+=~/.vim/resources/thesaurus/mthesaur.txt


" --------------------------------------------------
" Vimtex Settings
" --------------------------------------------------
set shellslash
set grepprg=grep\-nH\$*

set tabstop=4
set shiftwidth=4
set expandtab

" http://superuser.com/questions/302186/vim-scrolls-very-slow-when-a-line-is-too-long
set lazyredraw
set synmaxcol=1000

let g:tex_comment_nospell = 1
let g:tex_conceal = "abdg"
let g:vimtex_view_method = "zathura"
let g:vimtex_fold_enabled = 1
