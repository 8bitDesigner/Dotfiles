" Prep some variables for use with syntastic syntax checker
let g:syntastic_auto_loc_list=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_jshint_config = '~/.jshintrc'
let g:syntastic_sass_checkers = ['scss_lint']
let g:syntastic_scss_checkers = ['scss_lint']
" let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_html_checkers=[]

" Init pathogen
call pathogen#runtime_append_all_bundles()

" 256 color term
set t_Co=256

" Better colour scheme
set background=dark
colorscheme solarized

" Activate auto filetype detection
filetype plugin indent on
au BufRead,BufNewFile *.es6    set filetype=javascript
au BufRead,BufNewFile *.jsx    set filetype=javascript
au BufRead,BufNewFile *.ejs    set filetype=php
au BufRead,BufNewFile *.md     set filetype=markdown
au BufRead,BufNewFile *.nghtml set filetype=html
au BufRead,BufNewFile *        set foldmethod=syntax
au VimEnter,BufRead,BufNewFile * :call Whitespace()         " Turn on space highlighting at boot
au FileType nerdtree,taglist,qf setlocal nornu              " Kill line numbers in some buffers
autocmd filetype make setlocal noexpandtab

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent   " Enable folding in *.coffee files
au BufNewFile,BufReadPost *.stylus setl foldmethod=indent   " Enable folding in *.stylus files

syntax enable
runtime macros/matchit.vim

set statusline=%F%h%m%r%=[%b\ 0x%02B]\ \ \ %l,%c%V\ %P
set ignorecase            " Don't care about case...
set smartcase             " ... unless the query contains upper case characters
set nowrap                " No fake carriage returns
set showcmd               " Show command in statusline as it's being typed
set showmatch             " Jump to matching bracket
set ruler                 " Show row,col %progress through file
set visualbell            " Don't yell at me
set imd                   " The input managerwhich seems to hate Dvorak.
set ff=unix               " Read/Write/Breathe Unix
set scrolloff=3           " Keep 3 lines of context around the cursor
set clipboard=unnamed     " Use system clipboard for yank/paste
set directory=/tmp        " Single location for swap files
set rnu                   " Relative line numbering
set mousefocus            " Follow mouse focus
set fillchars=fold:\ 
set splitright            " Open splits on the right
set splitbelow            " Open splits below

" Sane tabbing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Omni completion
set ofu=syntaxcomplete#Complete " Enable syntax completion?
set completeopt=longest         " Show longest match, at lest one option

let mapleader = ","       " Leader mapping
let g:vimsyn_folding='af' " Folding settings

if has('nvim')
  set clipboard+=unnamedplus
endif

if version >= 703
  " Persistent undo - http://amix.dk/blog/post/19548
  set undofile
  set undodir=/tmp
  set undolevels=1000
  set undoreload=10000

  " highlight line 80
  set colorcolumn=80
endif

if !has('nvim')
  set wildmenu              " Better edit menu navigation
  set wildmode=full,longest " Configure autocomplete list for fs navigation
  set listchars=tab:▸\ 
  set mouse=a               " Use mouse in normal and visual modes
  set laststatus=2          " Display statusline
  set incsearch             " Use incremental search
  set autoindent            " Enable automatic indenting for files with ft set
  set ttymouse=xterm2       " Mouse + tmux/screen == happy
  set bs=2                  " Backspace like the good lord intended
endif

if has('nvim')
  set wildignorecase        " Ignore case on filesystem autocomplete
endif

" Toggle invisibles and trailing characters
nmap <leader>l :call Whitespace()<CR>
function! Whitespace()
  " Set up the color for our highlight group and tab characters
  highlight ExtraWhitespace ctermbg=red guibg=red

  set list! " Toggle the current list setting
  if &list == 0
    " If list is off, hide trailing whitespace
    syntax clear ExtraWhitespace
  else
    " else highlight
    syntax match ExtraWhitespace /\s\+\%#\@<!$/ containedin=ALL
  endif
endfunction

" FZF
map <c-t> :Files<CR>
map <leader>l :Lines<CR>
map <leader>h :History:<CR>
map <leader>H :Help<CR>

" Tern
let tern_show_signature_in_pum="1"
map <leader>d :TernDefSplit<CR>
map <leader>D :TernDocBrowse<CR>
map <leader>r :TernRefs<CR>
map <leader>R :TernRename<CR>
map <leader>t :TernType<CR>

" Pipe current document through markdown
map <leader>m :%!multimarkdown<CR>

" Let's get nerdy
map <leader>n :NERDTreeToggle<CR>
nmap <leader>/ <Plug>CommentaryLine
xmap <leader>/ <Plug>Commentary

" Tab/window shortcuts
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
set foldlevel=20
nnoremap <Space> za
map <S-Left> :foldclose<CR>
map <S-Right> :foldopen<CR>

" Because I can't type worth poo
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cmap Q q

" Change indent continuously (Awesome)
vmap < <gv
vmap > >gv

"Mapping option left/right
map  [C  w
map  [D  b
map  [1;3C w
map  [1;3D b
imap [C  wa
imap [D  bi
imap [1;3C wa
imap [1;3D bi

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

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif


" Switch between dark and light backgrounds
nmap \ :call ToggleBG()<CR>
function! ToggleBG()
  if &background == 'light'
    set background=dark
  else
    set background=light
  endif
endfunction
