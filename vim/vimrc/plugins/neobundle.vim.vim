" ==================================================
" Bundles
" ==================================================

" --------------------------------------------------
" Common
" --------------------------------------------------

" Libraries
NeoBundleLazy 'mattn/webapi-vim'

" Vim plugins management
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'MarcWeber/vim-addon-local-vimrc'

" Acceleration of Vim functionalities
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'sjl/gundo.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'austintaylor/vim-indentobject'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'vim-scripts/marvim'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'AndrewRadev/sideways.vim'
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'AndrewRadev/inline_edit.vim'
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'chrisbra/Recover.vim'
NeoBundle 'tyru/vim-altercmd'

" Programming Features
NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'ujihisa/quicklearn'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'majutsushi/tagbar'

" Integration with outer softwares / services
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'mattn/gist-vim'
NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'tyru/open-browser.vim'
NeoBundle 'pydave/AsyncCommand'
NeoBundleLazy 'wannesm/wmgraphviz.vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'mileszs/ack.vim'
NeoBundleLazy 'lordm/vim-browser-reload-linux'

" For beautiful texts
NeoBundle 'godlygeek/tabular'
NeoBundleLazy 'jngeist/vim-multimarkdown'

" Visual
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'nathanaelkane/vim-indent-guides'

" Unite sources
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'

" Other Utilities
NeoBundleLazy 'fuenor/qfixhowm'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Genki-S/dry.vim'
NeoBundle 'fuenor/im_control.vim'
NeoBundleLazy 'gregsexton/VimCalc'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------

" Ruby
" --------------------------------------------------
NeoBundleLazy 'vim-ruby/vim-ruby'
NeoBundleLazy 'astashov/vim-ruby-debugger'
NeoBundleLazy 'taka84u9/vim-ref-ri'

" TeX
" --------------------------------------------------
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box'

" Web
" --------------------------------------------------
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundleLazy 'tpope/vim-haml'
NeoBundleLazy 'Valloric/MatchTagAlways'
NeoBundleLazy 'othree/html5.vim'
NeoBundleLazy 'hokaccha/vim-html5validator'
NeoBundleLazy 'pangloss/vim-javascript'
NeoBundleLazy 'hallettj/jslint.vim'
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'cakebaker/scss-syntax.vim'
NeoBundleLazy 'miripiruni/CSScomb-for-Vim'

" Scala
" --------------------------------------------------
NeoBundleLazy 'derekwyatt/vim-scala'

" Scilab
" --------------------------------------------------
NeoBundleLazy 'vim-scripts/scilab.vim'

" Sourcings
" --------------------------------------------------

" plugin - filetype dictionary
let s:plugin_filetypes = {
\	'vim-ruby': [
\		'ruby'
\	],
\	'vim-ruby-debugger': [
\		'ruby'
\	],
\	'vim-ref-ri': [
\		'ruby'
\	],
\	'LaTeX-Box': [
\		'tex', 'plaintex'
\	],
\	'zencoding-vim': [
\		'html', 'xhtml', 'haml', 'php'
\	],
\	 'vim-haml': [
\		'haml'
\	],
\	'MatchTagAlways': [
\		'html', 'xhtml', 'xml', 'php'
\	],
\	'html5.vim': [
\		'html', 'php'
\	],
\	'vim-html5validator': [
\		'html'
\	],
\	'vim-javascript': [
\		'javascript'
\	],
\	'jslint.vim': [
\		'javascript'
\	],
\	'vim-css3-syntax': [
\		'css', 'scss'
\	],
\	'scss-syntax': [
\		'scss'
\	],
\	'CSScomb-for-Vim': [
\		'css', 'scss'
\	],
\	'vim-scala': [
\		'scala'
\	],
\	'scilab.vim': [
\		'scilab'
\	]
\}

" helper function
function! s:source_lazy_plugin(plugin)
	try
		execute 'NeoBundleSource' a:plugin
	catch /^Vim\%((\a\+)\)\?:E127/
		" TODO: inspect what is going on about E127
	endtry
endfunction

" define sourcing autocmd
augroup sourcings
	autocmd!
augroup END
for [plugin, ftlist] in items(s:plugin_filetypes)
	augroup sourcings
		execute "autocmd FileType" join(ftlist, ',') "call s:source_lazy_plugin('".plugin."')"
	augroup END
endfor

" --------------------------------------------------
" Installation check
" --------------------------------------------------
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
\		string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" ==================================================
" Plugin settings
" ==================================================

" --------------------------------------------------
" Interface
" --------------------------------------------------
command! -nargs=1 -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSetting
	\ call s:edit_plugin_setting(<q-args>)

" --------------------------------------------------
" Helper Functions
" --------------------------------------------------
let s:plugin_names = map(neobundle#config#get_neobundles(), 'v:val.name')

function! s:source_plugin_setting(plugin_name)
	let l:fullpath = g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
	if filereadable(l:fullpath)
		execute 'source' l:fullpath
	endif
endfunction

function! s:source_all_plugin_settings()
	for plugin in s:plugin_names
		if plugin !=# 'neobundle.vim'
			call s:source_plugin_setting(plugin)
		endif
	endfor
endfunction

function! s:edit_plugin_setting(plugin_name)
	execute 'edit' g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
endfunction

" Initialization
call s:source_all_plugin_settings() " I know this is not cool
" TODO: souce settings for lazy plugins when those are sourced (need to hook NeoBundleSource command?)
