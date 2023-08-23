"* Dvorak remappings *"
" (nothing to change) h -> move left, H -> screen top

" t -> move down (with wrapping), T -> join lines
noremap t gj
noremap T J

" n -> move up (with wrapping), j/J -> jump between matches
noremap n gk
noremap j n
noremap J N

" s -> move right, S -> screen bottom
noremap s l
noremap S L

" For window navigation
" TODO: make these more complete (e.g. to include moving windows)
" (To access overridden bindings, hold Ctrl for the second key stroke.)

" (nothing to change) <C-W>h -> Move to left window

" <C-W>t -> move to window below
noremap <C-w>t <C-w>j

" <C-W>n -> move to window above
noremap <C-w>n <C-w>k

" <C-W>s -> move to window to right
noremap <C-w>s <C-w>l
