if exists("did_load_filetypes_userafter")
	finish
endif
augroup filetypedetect
	" ROS launch files -> XML
	au! BufNewFile,BufRead *.launch setf xml
	" GLSL (http://vim.org/scripts/script.php?script_id=1002)
	au! BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set syntax=glsl
	" *.md -> Markdown (Vim 7.2 identifies *.md files as Modula-2)
	au! BufNewFile,BufRead *.md setf markdown
augroup END
