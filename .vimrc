call pathogen#runtime_append_all_bundles()

let g:ale_linters = {
\ 'json': ['jsonlint'],
\ 'jsonc': ['jsonlint'],
\ 'typescript': ['eslint', 'tsserver'],
\ 'javascript': ['eslint', 'tsserver'],
\ 'javascriptreact': ['eslint', 'tsserver'],
\ 'typescriptreact': ['eslint', 'tsserver'],
\ 'vue': ['volar']
\}

" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

let g:ale_vue_volar_executable = 'vue-language-server'
let g:ale_open_list = 1 " Show quickfix window when errors occur
let g:ale_keep_list_window_open = 0
let g:ale_completion_enabled = 0
let g:ale_set_balloons = 1

" 256 color term
set t_Co=256

" Better colour scheme
colorscheme one

autocmd VimEnter * call SetTheme()

filetype plugin indent on " Activate auto filetype detection

autocmd filetype nerdtree,taglist,qf setlocal nonumber colorcolumn= " Kill line numbers, color column in some buffers
autocmd filetype make setlocal noexpandtab
autocmd filetype json set filetype=json " Oof, something was setting my json filetype to cjson

" Enable truecolor support when running inside of Tmux (which is to say,
" always)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
set number                " Set line numbering
set mousefocus            " Follow mouse focus
set fillchars=fold:\ 
set splitright            " Open splits on the right
set splitbelow            " Open splits below
set foldmethod=syntax     " Code folding!
set backupcopy=yes        " File watchers get fussy if this is off

" Sane tabbing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Omni completion
" set ofu=syntaxcomplete#Complete " Enable syntax completion?
set completeopt=longest         " Show longest match, at lest one option
set omnifunc=ale#completion#OmniFunc

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
  set synmaxcol=180 "" Only syntax highlight up to column 120
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

" YouCompleteMe
map <leader>d :YcmCompleter GoTo<CR>
map <leader>D :YcmCompleter GetDoc<CR>
map <leader>r :YcmCompleter GoToReferences<CR>

" FZF
map <c-t> :Files<CR>
map <leader>h :History:<CR>
map <leader>H :Help<CR>

" Pipe current document through markdown
map <leader>m :%!multimarkdown<CR>

" Let's get nerdy
map <leader>n :NERDTreeToggle<CR>
nmap <leader>/ <Plug>CommentaryLine
xmap <leader>/ <Plug>Commentary

" Navigation shortcuts
map <leader>] :tabn<CR>
map <leader>[ :tabp<CR>
nmap <leader> <C-x><C-o>
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

function! SetTheme()
  let result = system('defaults read -g AppleInterfaceStyle 2>/dev/null')
  if v:shell_error
    set background=light
  else
    set background=dark
  endif
endfunction
