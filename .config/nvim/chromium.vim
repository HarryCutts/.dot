let s:chromiumroot=$HOME . '/dev/chromium'

function s:UseChromiumStyle()
	setlocal shiftwidth=2
	setlocal tabstop=2
	setlocal softtabstop=2
	setlocal expandtab
	setlocal textwidth=80
	setlocal colorcolumn=80
endfunction

if isdirectory(s:chromiumroot)
	" Mojom syntax highlighting
	let &runtimepath.=',' . s:chromiumroot . '/src/tools/vim/mojom'

	" Assorted other filetypes
	exe 'source' (s:chromiumroot . '/src/tools/vim/filetypes.vim')

	autocmd BufRead,BufNewFile */dev/chromium/* call s:UseChromiumStyle()
endif
