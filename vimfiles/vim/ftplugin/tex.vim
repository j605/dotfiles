" --------------------------------------------------
" Text writing setting
" --------------------------------------------------
setlocal spell spelllang=en_gb
setlocal thesaurus+=~/.vim/resources/thesaurus/mthesaur.txt


" --------------------------------------------------
" Vimtex Settings
" --------------------------------------------------
set shellslash

set tabstop=4
set shiftwidth=4

" http://superuser.com/questions/302186/vim-scrolls-very-slow-when-a-line-is-too-long
set lazyredraw
set synmaxcol=1000

set textwidth=79
set linebreak
set formatoptions=cqronl1j
let g:vimtex_format_enabled = 1

" makes more sense for prose.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

let g:tex_comment_nospell = 1
let g:tex_conceal = "abdg"
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
let g:vimtex_fold_enabled = 1
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
        \ 'background' : 1,
        \ 'build_dir' : './build',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-shell-escape',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'
end
