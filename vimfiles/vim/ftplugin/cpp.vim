inoremap <silent> <buffer> <Leader><C-l> <Space>>><Space>
inoremap <silent> <buffer> <Leader><C-h> <Space><<<Space>

set tabstop=4
set shiftwidth=4
set noexpandtab " newsboat uses tabs

" ==================================================
" Make"prg"file
" ==================================================
let s:CC = "g++"
let s:WARNCPPFLAGS = "-Wall -W -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wold-style-cast -Woverloaded-virtual"
let s:LDFLAGS = "-g"
" let s:LOADLIBES = "-lefence"
let s:LOADLIBES = ""
let s:EXE = "a.out"
let s:MKPRG = join([s:CC, s:LDFLAGS, s:WARNCPPFLAGS, "-o", s:EXE, "%", s:LOADLIBES])

" ==================================================
" Set local makeprg
" ==================================================
if filereadable('Makefile')
	setlocal makeprg=make
else
	execute "setlocal makeprg=" . escape(s:MKPRG, " ")
endif
