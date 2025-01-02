source ~/.dot/dvorak.vim

set hidden

set splitbelow splitright

set completeopt=menu,preview,longest
set wildmode=longest:full
set wildmenu

set cursorline
set number
set scrolloff=5

set nowrap

filetype plugin indent on

" Enable true colour (on Neovim 0.1.5+)
if (has("termguicolors"))
	set termguicolors
endif

runtime chromium.vim
runtime chromiumos.vim

if !empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'dmix/elvish.vim', { 'on_ft': ['elvish'] }
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'overcache/NeoSolarized'
	Plug 'udalov/kotlin-vim'
	Plug 'vivien/vim-linux-coding-style'
	call plug#end()

	" christoomey/vim-tmux-navigator: Dvorak bindings
	let g:tmux_navigator_no_mappings = 1

	nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
	nnoremap <silent> <c-t> :TmuxNavigateDown<cr>
	nnoremap <silent> <c-n> :TmuxNavigateUp<cr>
	nnoremap <silent> <c-s> :TmuxNavigateRight<cr>
	nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

	" overcache/NeoSolarized
	set background=light
	colorscheme NeoSolarized

	" vivien/vim-linux-coding-style: Disable by default.
	let g:linuxsty_patterns = []
else
	echo "vim-plug is not installed; some features may be unavailable. To install it, see https://github.com/junegunn/vim-plug#neovim."
endif
