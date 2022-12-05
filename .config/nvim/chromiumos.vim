let s:crosroot=$HOME . '/chromiumos'

function s:UseKernelStyle()
	setlocal colorcolumn=80
	if exists(":LinuxCodingStyle")
		LinuxCodingStyle
	endif
endfunction

if isdirectory(s:crosroot)
	autocmd BufRead,BufNewFile */src/platform/ec/*.{c,h,inc,wrap,tasklist,mocklist} call s:UseKernelStyle()
	autocmd BufRead,BufNewFile */src/third_party/kernel/* call s:UseKernelStyle()
endif
