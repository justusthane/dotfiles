"" Fix for ConEmu color. Try changing to if !empty($CONEMUBUILD) if it messes
"" up on mac
"if !has("gui_running")
"  set term=xterm
"  set t_Co=256
"  set termencoding=utf8
"  let &t_AB="\e[48;5;%dm"
"  let &t_AF="\e[38;5;%dm"
"  inoremap <silent> <Char-206> 
"  cnoremap <silent> <Char-206> 
"endif
set rtp+=/usr/local/opt/fzf

packadd! matchit

" set the runtime path to include Vundle and initialize
if has("win32")
  
else
  
endif

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'michalliu/jsruntime.vim'
Plug 'michalliu/jsoncodecs.vim'
Plug 'michalliu/sourcebeautify.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'KabbAmine/vCoolor.vim'
"Plug 'niftylettuce/vim-jinja'
Plug 'othree/xml.vim'
Plug 'PProvost/vim-ps1'
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'svermeulen/vim-macrobatics'
"Plug 'SirVer/ultisnips'
call plug#end()

" coc.nvim extensions
let g:coc_global_extensions=[ 'coc-powershell','coc-pyright' ]

"Mouse support
:set mouse=a
colorscheme gruvbox
set background=dark
let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'
inoremap jj <Esc>
nnoremap zz <Esc>:w<Cr>
nnoremap zz :w<Cr>
" Select last paste
nnoremap gp `[v`]
let g:user_emmet_leader_key='<C-Y>'

"let g:netrw_liststyle = 3 " netrw use tree view by default

" from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
filetype plugin indent on
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
syntax on

set omnifunc=syntaxcomplete#Complete


"set modelines=0
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
"set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set display=lastline " Show as much as possible of wrapped lines
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile
set splitright
let mapleader = ","
set autochdir

set backupdir=.backup/,~/.vim/backup//,~/vimfiles/backup//,./
set directory=.swp/,~/.vim/swp//,~/vimfiles/swp//,./
set undodir=.undo/,~/.vim/undo//,~/vimfiles/undo//,./

"Hybrid line numbers in command mode, absolute numbers in insert mode
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"fzf keybindings
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :call fzf#run({'source': 'fd --type file . C:\Users\jbadergr', 'sink': 'e'})<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>

nmap <Leader>ex :Explore<Cr>


" https://github.com/svermeulen/vim-macrobatics
" Use <nowait> to override the default bindings which wait for another key press
nmap gqp <plug>(Mac_Play)
nmap gq <plug>(Mac_RecordNew)

nmap <leader>mh :DisplayMacroHistory<cr>

nmap [m <plug>(Mac_RotateBack)
nmap ]m <plug>(Mac_RotateForward)

nmap <leader>ma <plug>(Mac_Append)
nmap <leader>mp <plug>(Mac_Prepend)

nmap <leader>mng <plug>(Mac_NameCurrentMacro)
nmap <leader>mnf <plug>(Mac_NameCurrentMacroForFileType)
nmap <leader>mns <plug>(Mac_NameCurrentMacroForCurrentSession)

nmap <leader>mo <plug>(Mac_SearchForNamedMacroAndOverwrite)
nmap <leader>mr <plug>(Mac_SearchForNamedMacroAndRename)
nmap <leader>md <plug>(Mac_SearchForNamedMacroAndDelete)
nmap <leader>me <plug>(Mac_SearchForNamedMacroAndPlay)
nmap <leader>ms <plug>(Mac_SearchForNamedMacroAndSelect)

"set wrap
"set textwidth=79
set formatoptions=qrn1
set colorcolumn=85


nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

nnoremap ; :
"end of http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines

noremap <buffer> <leader>e :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
inoremap <buffer> <leader>e <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

"Quickly open .vimrc
:nnoremap <leader>ev :edit $MYVIMRC<cr> 
"Quickly source .vimrc 
:nnoremap <leader>sv :source $MYVIMRC<cr>

au BufNewFile,BufRead *.njk set ft=jinja
au BufNewFile,BufRead *.xml set formatexpr=xmlformat#Format()

":source ~/dotfiles/vimrc_coc.nvim
set dir=~
:cd ~

" Needed for tab to function with coc.vim

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
set whichwrap=b,s,<,>
