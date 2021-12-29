"n-----------General Setings--------
set number
set visualbell
set cin
set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40
set mouse=a
"set scrolloff=999
set laststatus=2
set splitright
"-----------Theming---------------
color vim-hardaway
"-----------Key Mappings----------
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
"nmap G Gzz
nmap n nzz
nmap N Nzz
imap <CR> <CR><ESC>i
"-----------autocmd---------------
"autocmd InsertEnter * norm zz
"-----------plugged---------------
call plug#begin('~/.vim/plugged')
"LightLine
Plug 'itchyny/lightline.vim'
"Enfocado Color
Plug 'wuelnerdotexe/vim-enfocado'
"Vim-Hardway Color
Plug 'evturn/vim-hardaway'
call plug#end()
