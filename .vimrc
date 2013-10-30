" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Enable Pathogen by Tim Pope
execute pathogen#infect()

" Enable theme
set background=dark " dark | light "
colorscheme solarized 

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set tabstop=4 "Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4 "Number of spaces to use for each step of (auto)indent.
set softtabstop=4 "Number of spaces that a <Tab> counts for while performing editing.
set expandtab "In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$


"------------------------------------------------------------
"
" Powerline setup
set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim/
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2


"-------------------------------------------------------------
"
"Leader stuff
" Change <leader> key.
let mapleader = ","

function! Djangomode()
    if &ft == 'python'            " FIXME
    echom 'python was here'       " FIXME
    set ft=python.django          " FIXME
    elseif &ft == 'python.django' " FIXME
    echom 'pd was here'           " FIXME
    set ft=python                 " FIXME
    elseif &ft == 'html'
        echom 'html was here'
        set ft=htmldjango.html
    elseif &ft == 'htmldjango.html'
        echom 'hd was here'
        set ft=html
    endif
endfunction


" Command re-mappings
cmap dma ! ./manage.py 
cmap WQ wq
cmap Wq wq
cmap W w
cmap Q q
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <leader><space> :noh<cr>
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>e :Errors<CR>
nnoremap <Leader>s :SyntasticCheck<CR>
nnoremap <Leader>E :SyntasticReset<CR>
nnoremap <Leader>f :CommandT<CR>
nnoremap <Leader>d :call Djangomode()<CR>
"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']

"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"

" Save when losing focus.
au FocusLost * :wa

" This makes Vim show invisible characters with the same characters that
" TextMate uses.
set list

" Makes Vim handle long lines correctly:
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85


" Searching / moving.
"fix regex.
nnoremap / /\v
vnoremap / /\v
set ignorecase "Make Vim deal with case-sensitive search intelligently.
set smartcase "Make Vim deal with case-sensitive search intelligently.
set gdefault "Applies substitutions globally on lines.
set incsearch "Work together to highlight search results (as you type).
set showmatch "Work together to highlight search results (as you type).
set hlsearch "Work together to highlight search results (as you type).
set mouse=a "Enable mouse usage (all modes).

" Source the vimrc file after saving it
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Color of line numbers.
hi LineNr ctermfg=darkgrey ctermbg=black

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Save when losing focus.
au FocusLost * :wa

"}}}
" Syntastic{{{
" On by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }

" Set sytastic prompt
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors=1

" Use flake8
let g:syntastic_python_checkers = ['flake8', 'pep8', 'python']
let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'
"}}}
" Command-T {{{

