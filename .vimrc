	" Better colour scheme
colorscheme putty

" Activate auto filetype detection
filetype plugin indent on
syntax enable
runtime macros/matchit.vim

set ignorecase		" Don't care about case...
set smartcase		" ... unless the query contains upper case characters
set autoindent		" Enable automatic indenting for files with ft set
set nowrap			" No fake carriage returns
set showcmd			" Show command in statusline as it's being typed
set showmatch		" Jump to matching bracket
set ruler			" Show row,col %progress through file
set softtabstop=4	" Vim sees 4 spaces as a tab
set shiftwidth=4	" < and > uses spaces
set tabstop=4		" 4-space indents
set incsearch		" Use incremental search
set visualbell		" Don't yell at me
set bs=2			" Backspace like the good lord intended
set imd				" Disable the input manager, which seems to hate Dvorak.
set ff=unix			" Read/Write/Breathe Unix
set scrolloff=3		" Keep 3 lines of context around the cursor whens scrolling
set wildmode=list:longest,full	

let mapleader = ","			" Leader mapping
let use_xhtml = 1			" Use HTML when outputting formatted data
let html_use_css = 1		" Use CSS when building HTML
let g:vimsyn_folding='af'	" Folding settings


" If, for some strange reason, I ever output my stuff to HTML, vim should better use CSS to do the deed
map <leader>h :TOhtml<CR>

" Pipe current document through HTML tidy
map <leader>n :%!tidy -cim -wrap 0 --indent-spaces 4 --tab-size 8 --tidy-mark no --show-warnings 0<CR><CR>%s/    /	/g

" Pipe current document through markdown
map <leader>m :%!perl ~/usr/bin/Markdown.pl<CR>

" Let's get nerdy
map <leader>n :NERDTreeToggle<CR>
"
" Wraps visual selection in an HTML tag
map <leader>w >:call VisualHTMLTagWrap()<CR>

" Adium stlye tab shortcuts
map <C-T> :tabnew<CR>
map <C-Right> :tabn<CR>
map <C-Left> :tabp<CR>
map <C-Up> :tabfirst<CR>
map <C-Down> :tablast<CR>
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


" VisualHTMLTagWrap(): Wraps visual selection in an HTML tag {{{3
function! VisualHTMLTagWrap()
    let html_tag = tolower( input( "html_tag to wrap block: ") )
    let jumpright = 2 + strlen( html_tag )
    normal `<
    let init_line = line( "." )
    exe "normal i<".html_tag.">"
    normal `>
    let end_line = line( "." )
    " Don't jump if we're on a new line
    if( init_line == end_line )
	" Jump right to compensate for the characters we've added
	exe "normal ".jumpright."l"
    endif
    exe "normal a</".html_tag.">"
endfunction
" }}}3


" Markdown highlighting
augroup mkd
	autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END



" ViM autocommands for binary plist files
" Copyright (C) 2005 Moritz Heckscher
"
" Note: When a file changes externally and you answer no to vim's question if
" you want to write anyway, the autocommands (e.g. for BufWritePost) are still
" executed, it seems, which could have some unwanted side effects.
"
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
augroup plist
	" Delete existing commands (avoid problems if this file is sourced twice)
	autocmd!

	" Set binary mode (needs to be set _before_ reading binary files to avoid
	" breaking lines etc; since setting this for normal plist files doesn't
	" hurt and it's not yet known whether or not the file to be read is stored
	" in binary format, set the option in any case to be sure).
	" Do it before editing a file in a new buffer and before reading a file
	" into in an existing buffer (using ':read foo.plist').
	autocmd BufReadPre,FileReadPre *.plist set binary

	" Define a little function to convert binary files if necessary...
	fun MyBinaryPlistReadPost()
		" Check if the first line just read in indicates a binary plist
		if getline("'[") =~ "^bplist"
			" Filter lines read into buffer (convert to XML with plutil)
			'[,']!plutil -convert xml1 /dev/stdin -o /dev/stdout
			" Many people seem to want to save files originally stored
			" in binary format as such after editing, so memorize format.
			let b:saveAsBinaryPlist = 1
		endif
		" Yeah, plain text (finally or all the way through, either way...)!
		set nobinary
		" Trigger file type detection to get syntax coloring etc. according
		" to file contents (alternative: 'setfiletype xml' to force xml).
		filetype detect
	endfun
	" ... and call it just after editing a file in a new buffer...
	autocmd BufReadPost *.plist call MyBinaryPlistReadPost()
	" ... or when reading a file into an existing buffer (in that case, don't
	" save as binary later on).
	autocmd FileReadPost *.plist call MyBinaryPlistReadPost() | let b:saveAsBinaryPlist = 0

	" Define and use functions for conversion back to binary format
	fun MyBinaryPlistWritePre()
		if exists("b:saveAsBinaryPlist") && b:saveAsBinaryPlist
			" Must set binary mode before conversion (for EOL settings)
			set binary
			" Convert buffer lines to be written to binary
			silent '[,']!plutil -convert binary1 /dev/stdin -o /dev/stdout
			" If there was a problem, e.g. when the file contains syntax
			" errors, undo the conversion and go back to nobinary so the
			" file will be saved in text format.
			if v:shell_error | undo | set nobinary | endif
		endif
	endfun
	autocmd BufWritePre,FileWritePre *.plist call MyBinaryPlistWritePre()
	fun MyBinaryPlistWritePost()
		" If file was to be written in binary format and there was no error
		" doing the conversion, ...
		if exists("b:saveAsBinaryPlist") && b:saveAsBinaryPlist && !v:shell_error
			" ... undo the conversion and go back to nobinary so the
			" lines are shown as text again in vim.
			undo
			set nobinary
		endif
	endfun
	autocmd BufWritePost,FileWritePost *.plist call MyBinaryPlistWritePost()
augroup END
