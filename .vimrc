" Init pathogen 
call pathogen#runtime_append_all_bundles()

" 256 color term with a keypad
set t_Co=256
"set term=ansi

" Better colour scheme
set background=dark
colorscheme solarized

" Activate auto filetype detection
filetype plugin indent on
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

let mapleader = ","			" Leader mapping
let g:vimsyn_folding='af'	" Folding settings


" Search in files
map <C-T> :Ack 

" Pipe current document through markdown
map <leader>m :%!multimarkdown<CR>

" Let's get nerdy
map <leader>n :NERDTreeToggle<CR>

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


" Switch between dark and light backgrounds
nmap \ :call ToggleBG()<CR>
function! ToggleBG()
  if &background == 'light'
    set background=dark
  else
    set background=light
  endif
endfunction
