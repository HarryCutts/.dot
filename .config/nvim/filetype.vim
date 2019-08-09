if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	" Chrome OS Embedded Controller C files with unusual extensions
	au! BufRead,BufNewFile *.{inc,wrap,tasklist,mocklist}	setfiletype c
augroup END
