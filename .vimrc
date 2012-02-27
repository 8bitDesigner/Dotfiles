" Init pathogen 
call pathogen#runtime_append_all_bundles()

" Better colour scheme
set background=dark
colorscheme solarized

" Activate auto filetype detection
filetype plugin indent on
syntax enable
runtime macros/matchit.vim

set ignorecase			" Don't care about case...
set smartcase			" ... unless the query contains upper case characters
set autoindent			" Enable automatic indenting for files with ft set
set nowrap				" No fake carriage returns
set showcmd				" Show command in statusline as it's being typed
set showmatch			" Jump to matching bracket
set ruler				" Show row,col %progress through file
set softtabstop=4		" Vim sees 4 spaces as a tab
set shiftwidth=4		" < and > uses spaces
set tabstop=4			" 4-space indents
set incsearch			" Use incremental search
set visualbell			" Don't yell at me
set bs=2				" Backspace like the good lord intended
set imd					" Disable the input manager, which seems to hate Dvorak.
set ff=unix				" Read/Write/Breathe Unix
set scrolloff=3			" Keep 3 lines of context around the cursor whens scrolling
set mouse=a				" Use mouse in normal and visual modes
set clipboard=unnamed	" Use system clipboard for yank/paste
set wildmenu
set wildmode=full,longest

let mapleader = ","			" Leader mapping
let use_xhtml = 1			" Use HTML when outputting formatted data
let html_use_css = 1		" Use CSS when building HTML
let g:vimsyn_folding='af'	" Folding settings


" If, for some strange reason, I ever output my stuff to HTML, vim should better use CSS to do the deed
map <leader>h :TOhtml<CR>

" Pipe current document through HTML tidy
map <leader>T :%!tidy -cim -wrap 0 --indent-spaces 4 --tab-size 8 --tidy-mark no --show-warnings 0<CR><CR>%s/    /	/g


" Pipe current document through markdown
map <leader>m :%!perl ~/usr/bin/Markdown.pl<CR>

" Let's get nerdy
map <leader>n :NERDTreeToggle<CR>
"
" Wraps visual selection in an HTML tag
map <leader>w >:call VisualHTMLTagWrap()<CR>

" Tab/window shortcuts
map <C-T> :tabnew<CR>
map <C-Right> :tabn<CR>
map <C-Left> :tabp<CR>
map <C-Up> :tabfirst<CR>
map <C-Down> :tablast<CR>
map <leader>t :tabnew<CR>
map <leader>] :tabn<CR>
map <leader>[ :tabp<CR>

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


nmap \ :call ToggleBG()<CR>
function! ToggleBG()
  if &background == 'light'
    set background=dark
  else
    set background=light
  endif
endfunction
