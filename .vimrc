let g:vimfolder = '~/.vim'

"* Vundle *"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin('~/.vim/bundle')
Plugin 'gmarik/vundle'

"- Plugins -"
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules)$'

Plugin 'groenewege/vim-less'
Plugin 'git://github.com/tomasr/molokai.git'
Plugin 'scrooloose/syntastic'
" Recommended settings from Syntastic README
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

call vundle#end()

"* Miscellaneous *"
set nobackup

set ruler
set number

set nowrap

set scrolloff=5

set spellfile+=~/.vim/spell/en.utf-8.add

set tabpagemax=32

" Disable Ex mode
noremap Q <Nop>

"* Indentation *"
set autoindent
set tabstop=4
set shiftwidth=4
set noexpandtab

"* File Types *"

" Load file-type specific configs from .vim/ftplugin
filetype plugin indent on

"* Highlighting *"
syntax enable

set t_Co=256
colorscheme molokai
set background=dark

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"* Searching *"
set incsearch
set ignorecase
set smartcase

"* Insert mode completion *"
set completeopt=menu,preview,longest

"* Command completion *"
set wildmode=longest:full
set wildmenu

"* Key mappings *"
let mapleader=" "

"* Other configuration files *"
function! SourceIfExists(file)
	if filereadable(expand(a:file))
		exe 'source' a:file
	endif
endfunction

source ~/.dot/dvorak.vim
call SourceIfExists("~/.google-dotfiles/vim.vim")
