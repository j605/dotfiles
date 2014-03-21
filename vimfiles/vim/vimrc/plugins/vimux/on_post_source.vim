function! VimuxSendTextWithEnter(text)
	call VimuxSendText(a:text)
	call VimuxSendKeys("Enter")
endfunction

function! VimuxSendKeysWithGetchar(callback)
	call VimuxSendKeys(Genki_char2tmux(getchar()))
	execute a:callback
endfunction

function! Genki_char2tmux(char)
	let keymap = {
				\ 13 : "Enter",
				\ 32 : "Space",
				\ 27 : "Escape",
				\ }
	return get(keymap, a:char, nr2char(a:char))
endfunction

" args: command to run first
function! Genki_vimux_prompt_mode(args)
	edit _VimuxPrompt_
	call VimuxRunCommand(a:args)

	" mappings
	nnoremap <buffer> <silent> <CR> :call VimuxSendTextWithEnter(getline('.'))<CR>
	inoremap <buffer> <silent> <CR> <Esc>:call VimuxSendTextWithEnter(getline('.'))<CR>o
	nnoremap <buffer> <silent> <nowait> <Leader> :call VimuxSendKeys(Genki_char2tmux(getchar()))<CR>
	inoremap <buffer> <silent> <expr> <nowait> <Leader> getline('.')=='' ? '<ESC>:call VimuxSendKeysWithGetchar("startinsert")<CR>' : ','

	" buffer settings
	setlocal buftype=nofile
	setlocal nobuflisted
	setlocal noswapfile
	setlocal bufhidden=delete
	setlocal nonumber
	setlocal nowrap

	startinsert
endfunction

" augroup vimux_prompt_mode
	" autocmd!
	" autocmd BufWipeout _VimuxPrompt_
		" \ execute "save ~/.tmp/vim/vimux_prompt_" . localtime()
		" \| VimuxCloseRunner
" augroup END

command! -nargs=* VimuxPromptMode call Genki_vimux_prompt_mode(<q-args>)

" args: command to run first
function! Genki_vimux_buffer_dir()
	if bufname('%') =~# 'vimfiler'
		let buffer_dir = vimfiler#get_current_vimfiler().current_dir
	else
		let buffer_dir = expand('%:p:h')
	end
	call VimuxRunCommand('cd ' . buffer_dir)
endfunction

command! -nargs=* VimuxBufferDir call Genki_vimux_buffer_dir()
