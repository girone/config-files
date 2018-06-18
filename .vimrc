"" setup for diff mode only
if &diff
  "" Enables parallel scrolling for all open views.
  set scrollbind
  "" Ignore whitespace differences.
  set diffopt+=iwhite
else
endif

"" Set textwidth to 80 (70 for git-msg), this implies word wrap.
set textwidth=80
autocmd BufRead *COMMIT_EDITMSG set textwidth=80  " git commit messages
autocmd BufRead *html set textwidth=0

"" When scrolling, always show some context (very helpful with search and
"" replace when you need some context).
set scrolloff=5

"" Don't redraw while executing macros (good performance config)
set lazyredraw

"" For regular expressions turn magic on
"set magic

"" Do not break long lines.
set nowrap
set listchars=eol:$,extends:>

"" Show matching braces.
set showmatch
hi MatchParen cterm=underline ctermbg=none
"" How many tenths of a second to blink when matching brackets
set mat=2

"" Set to auto read when the file is changed from the outside
"set autoread

"" Show line numbers
set number

"" Highlight search hits
set hlsearch
"" Ignore lower-/Uppercase during search
set ignorecase
"" Try to be smart about cases
set smartcase
"" Search as you type
set incsearch

"" Syntax highlightning, but only for color terminals.
if &t_Co > 1
  syntax on
endif

"" Set update time to 1 second (default is 4 seconds), convenient vor taglist.vim.
set updatetime=500

"" Allow mouse usage in Visual, Normal and Insert mode.
set mouse:nvi

"" Keep the horizontal cursor position when moving vertically.
set nostartofline

"" Automatically change window's cwd to file's dir.
" set autochdir

"" Replace TAB with four spaces
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
autocmd FileType cpp setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType h setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
"" But TABs are needed in Makefiles
autocmd BufNewFile,BufReadPost Makefile set noexpandtab
"" ADITION: do not replace tabs in C++
"autocmd FileType c,cpp,h,hpp,cc,java,php set noexpandtab
"autocmd FileType c,cpp,h,hpp set noexpandtab

"" Set indentation
set autoindent

"" OPTIONAL: This enables automatic indentation as you type (by 4 spaces)
filetype indent on
set sw=4

"" Remove trailing spaces when writing to source files
autocmd BufWritePre <buffer> :%s/\s\+$//e

"" Special for python
autocmd BufRead *py set shiftwidth=4
autocmd BufRead *py set softtabstop=4
autocmd BufRead *py set tabstop=4
autocmd BufRead *py set textwidth=79
autocmd BufRead *py iab ''' """

"" Toggle between .h and .cpp with F4.
function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "h"
    let ext = "cpp"
  elseif ext == "cpp"
    let ext = "h"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

"" Next / previous error with Tab / Shift+Tab.
"map <silent> <Tab> :cn<CR>
"map <silent> <S+Tab> :cp<CR>
"map <silent> <BS><Tab> :cp<CR>

"" Umlaut mappings for US keyboard.
"imap "a ä
"imap "o ö
"imap "u ü
"imap "s ß
"imap "A Ä
"imap "O Ö
"imap "U Ü

"" After this many msecs do not imap.
set timeoutlen=500

"" Always show the name of the file being edited.
set ls=2

"" Show the mode (insert,replace,etc.)
set showmode

"" No blinking cursor please.
set gcr=a:blinkon0

"" Cycle through completions with TAB (and SHIFT-TAB cycles backwards).
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

"" Cycling through Windows quicker.
map <C-M> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <A-Down>  <C-W><Down><C-W>_
map <A-Up>    <C-W><Up><C-W>_
map <A-Left>  <C-W><Left><C-W>|
map <A-Right> <C-W><Right><C-W>|

"" Do not show any line of minimized windows (Ctrl-w+_, Ctrl-w+=)
set wmh=0

"" Load file type specific scripts
autocmd FileType html,htm,xml source ~/.vim/scripts/closetag.vim
autocmd FileType html,htm,xml source ~/.vim/ftplugin/html.vim

"" Split windows below/right to the current window.
set splitbelow
set splitright

"" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"" Turn backup off, since most stuff is in SVN, git etc. anyway.
set nobackup
set nowb
set noswapfile

"" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Treat long lines as break lines (useful when moving around in them)
"map j gj
"map k gk

"" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Return to last edit position when opening files (You want this!)
"" The first condition disables this for git and hg commit messages.
autocmd BufReadPost *
   \ if expand('%:p') !~# '\m/\.git/' && line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
"" Remember info about open buffers on close
set viminfo^=%

"" Remap VIM 0 to first non-blank character
map 0 ^

"" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>


