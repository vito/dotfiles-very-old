set nocompatible

set enc=utf-8

set hidden

set guifont=Pragmata_TT:h9
set guioptions-=T
set noantialias

set ignorecase
set smartcase
set incsearch
set gdefault

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4

set path=**

set cursorline
set number
set numberwidth=5

set wildmenu
set ruler

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set noswapfile

syntax on
filetype on
filetype plugin on
filetype indent on
colorscheme text_ex_machina

map <F6> :echo "hi<".synIDattr(synID(line("."),col("."),1),"name")."> trans<".synIDattr(synID(line("."),col("."),0),"name")."> lo<".synIDattr(synIDtrans(synID(line("."),col("."),1)),"name").">"<CR>

imap <C-c> <ESC>,c 
nmap <C-c> ,c 
vmap <C-c> ,c 

imap <C-=> <esc>mz>>`zlllla 
nmap <C-=> mz>>`zllll
vmap <C-=> >
imap <C--> <esc>mz<<`zhhhha
nmap <C--> mz<<`zhhhh
vmap <C--> <

nmap ' `

autocmd BufRead *.at set filetype=haskell
autocmd BufRead *.twig set filetype=htmltwig
autocmd BufRead *.rl set filetype=ragel
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

let php_highlight_quotes = 1
let php_short_tags = 0

let g:NERDShutUp = 1
let g:PHP_default_indenting = 1
let Grep_Xargs_Options = "-0"

runtime macros/matchit.vim

if &term =~ "rxvt-256color"
    "Set the cursor white in cmd-mode and orange in insert mode
    let &t_EI = "\<Esc>]12;white\x9c"
    let &t_SI = "\<Esc>]12;2\x9c"
    "We normally start in cmd-mode
    silent !echo -e "\e]12;white\x9c"
endif

"runtime guicolorscheme.vim

"GuiColorScheme text_ex_machina
