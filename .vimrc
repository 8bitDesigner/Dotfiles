" Prep some variables for use with syntastic syntax checker
let g:syntastic_auto_loc_list=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_jshint_config = '~/.jshintrc'

" Init pathogen 
call pathogen#runtime_append_all_bundles()

" 256 color term
set t_Co=256

" Better colour scheme
set background=dark
colorscheme solarized

" Activate auto filetype detection
filetype plugin indent on
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.ejs set filetype=php

syntax enable
runtime macros/matchit.vim

set ignorecase				" Don't care about case...
set smartcase				" ... unless the query contains upper case characters
set autoindent				" Enable automatic indenting for files with ft set
set nowrap					" No fake carriage returns
set showcmd					" Show command in statusline as it's being typed
set showmatch				" Jump to matching bracket
set ruler					" Show row,col %progress through file
set softtabstop=4			" Vim sees 4 spaces as a tab
set shiftwidth=4			" < and > uses spaces
set tabstop=4				" 4-space indents
set incsearch				" Use incremental search
set visualbell				" Don't yell at me
set bs=2					" Backspace like the good lord intended
set imd						" Disable the input manager, which seems to hate Dvorak.
set ff=unix					" Read/Write/Breathe Unix
set scrolloff=3				" Keep 3 lines of context around the cursor whens scrolling
set mouse=a					" Use mouse in normal and visual modes
set mousefocus				" Follow mouse focus
set clipboard=unnamed		" Use system clipboard for yank/paste
set wildmenu				" Better edit menu navigation
set wildmode=full,longest
set nobackup                " Don't write backup files
set nowritebackup


let mapleader = ","			" Leader mapping
let g:vimsyn_folding='af'	" Folding settings


" Search in files
map <C-T> :Ack 

" Pipe current document through markdown
map <leader>m :%!multimarkdown<CR>

" Let's get nerdy
map <leader>n :NERDTreeToggle<CR>
nmap <leader>/ :call NERDComment(0, "invert")<CR>
vmap <leader>/ <ESC>:call NERDComment(1, "invert")<CR>

" Tab/window shortcuts
map <leader>t :tabnew<CR>
map <leader>] :tabn<CR>
map <leader>[ :tabp<CR>

" Window navigation
map <leader><Left> h
map <leader><Right> l
map <leader><Up> k
map <leader><Down> j

" Toggle search highlighting
nmap ; :set invhlsearch<CR>

" Folding is cool... sometimes.
map <S-Left> :foldclose<CR>
map <S-Right> :foldopen<CR>

" Because I can't type worth poo
cmap W w
cmap Q q

" Change indent continuously (Awesome)
vmap < <gv
vmap > >gv

"Manually mapping keypad keycodes for iTerm & OSX
set t_K6=Ok
set t_K7=Om
set t_K8=Oo
set t_K9=Oj
set t_KA=OM
set t_KB=On
set t_KC=Op
set t_KD=Oq
set t_KE=Or
set t_KF=Os
set t_KG=Ot
set t_KH=Ou
set t_KI=Ov
set t_KJ=Ow
set t_KK=Ox
set t_KL=Oy
imap OX =


" Switch between dark and light backgrounds
nmap \ :call ToggleBG()<CR>
function! ToggleBG()
  if &background == 'light'
    set background=dark
  else
    set background=light
  endif
endfunction
