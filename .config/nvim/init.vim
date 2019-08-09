source ~/.dot/dvorak.vim

set hidden

set completeopt=menu,preview,longest
set wildmode=longest:full
set wildmenu

set cursorline
set number
set scrolloff=5

" Enable true colour (on Neovim 0.1.5+)
if (has("termguicolors"))
	set termguicolors
endif

runtime chromium.vim
runtime chromiumos.vim

if !empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'vivien/vim-linux-coding-style'
	call plug#end()

	set background=dark
	colorscheme palenight

	" Disable linuxsty.vim by default.
	let g:linuxsty_patterns = []
else
	echo "vim-plug is not installed; some features may be unavailable. To install it, see https://github.com/junegunn/vim-plug#neovim."
endif
