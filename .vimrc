"----------------------------------
"-----------General Setings--------
"----------------------------------

	set number
	set relativenumber
	set visualbell
	set cin
	set cursorline
	"hi CursorLine term=bold cterm=bold guibg=Grey40
	set mouse=a
	"set scrolloff=999
	set laststatus=2
	set splitbelow
	set splitright
          "set expandtab
	set tabstop=10
	set nobackup
	set noswapfile
	set clipboard+=unnamedplus
	set smartindent
	set shiftwidth=10
	set list
	set listchars=tab:\|_
	set ttymouse=sgr "Needed for mouse to work with Alacritty
"----------------------------------
"-----------Theming----------------
"----------------------------------
"
	color vim-hardaway

"----------------------------------
"-----------Key Mappings-----------
"----------------------------------

"----------------General-----------

	let mapleader=" "

""	map <ScrollWheelUp> <C-Y>
""	map <ScrollWheelDown> <C-E>
	map <C-h> <C-w>h
	map <C-l> <C-w>l
	map <C-k> <C-w>k
	map <C-j> <C-w>j
	map <silent> <leader>e :NERDTreeToggle<CR>
	"map <silent> <leader>ce :NERDTreeClose<CR>

"----------------Normail Mode------

	"nmap G Gzz
	nmap n nzz
	nmap N Nzz
	nmap <C-Up> ddkkp
	nmap <C-Down> ddp
""	nmap <C-p> "+gp
""	nmap <C-y> "+gy

"----------------Insert Mode-------

""	inoremap <CR> <ESC>o
	inoremap <C-h> <ESC>i
	inoremap <C-l> <ESC>lli
	inoremap <C-k> <ESC>lki
	inoremap <C-j> <ESC>lji
	inoremap <C-a> <ESC>A
	"inoremap ii <ESC>
	"inoremap < <><ESC>i
	inoremap ( ()<ESC>i
	inoremap [ []<Esc>i
	inoremap { {}<Esc>i
	inoremap " ""<ESC>i
"	inoremap ' ''<ESC>i
""	imap { {<CR><TAB><CR>}<ESC>kA
"----------------------------------
"-----------autocmd----------------
"----------------------------------

	"autocmd InsertEnter * norm zz "Always centered in Instert mode
	autocmd BufWritePre * %s/\s\+$//e

"----------------------------------
"-----------plugged----------------
"----------------------------------

	call plug#begin('~/.vim/plugged')
		" LightLine
		Plug 'itchyny/lightline.vim'
		" Enfocado Color
		Plug 'wuelnerdotexe/vim-enfocado'
		" Vim-Hardway Color
		Plug 'evturn/vim-hardaway'
		" Nerdtree
		Plug 'preservim/nerdtree'
		" FzF
		Plug 'junegunn/fzf', { 'do': { -> fzf#install () } }
		Plug 'junegunn/fzf.vim'
		" Syntestic
		Plug 'vim-syntastic/syntastic'
		" Atelier Heath Colors
		Plug 'atelierbram/vim-colors_atelier-schemes'
		" Verilog Syntax
		Plug 'vhda/verilog_systemverilog.vim'
	call plug#end()


