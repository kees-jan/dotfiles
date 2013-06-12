"-------------------------------------------------------------------------
"
" Sample .vimrc
"
" These are regular Vim commands that are executed upon
" startup. They are well-commented, pick whatever you like
"
"-------------------------------------------------------------------------
"
" Tip: Put this file in your Dropbox as vimrc.vim and put 
" the following in your actual .vimrc file (courtesy of Jan Ouwens):
"
"     set runtimepath+=~/Dropbox/Vim/vimfiles
"     source ~/Dropbox/Vim/vimrc.vim
"     
"-------------------------------------------------------------------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" If we're running in GUI mode, switch to Windows-like behaviour.
" Motivation: Ctrl-V (block select) is Ctrl-Q in Windows mode, but you can't
" use Ctrl-Q in a terminal (it has a special meaning), which is what I'm
" running vim on if not in GUI. So we need to load it *only* in GUI mode.
if has("gui_running")
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" My favorite color scheme
""colorscheme desert

" Disable toolbar and menu in GUI mode. That's precious screen space man!
if has("gui_running")
    set guioptions-=T      " Toolbar
    set guioptions-=m      " Menu bar
endif

" Some tweaks for Windows 
if has("win32") && has("gui_running")
    " Set a nicer font
    set guifont=Consolas:h11

    " Hit Window Maximize when entering GUI mode
    " Discriminate between my laptop (which is running a Dutch Windows) and my
    " home computer (which is running an English one) by using a file in the
    " home directory.
    if filereadable(expand("~/dutch"))
        au GUIEnter * simalt ~m 
    else
        au GUIEnter * simalt ~x
    endif
endif

" On Mac I prefer this font
if has("mac") && has("gui_running")
    set guifont=Monaco:h13
endif

" When typing a closing bracket, briefly flash the one it matches.
set showmatch
set matchtime=1

set foldlevel=20               " Folds will be open initially.
set showcmd                    " Show (partial) command in status line.
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set nowrap                     " Screen wrapping continually annoys me
set printfont=courier_new:h8   " Small print font (for when I'm printing code...)
set backspace=indent,eol,start " Allow backspacing everywhere.
set diffopt+=iwhite            " Ignore white space when diffing

set autoread                   " Reload files that have been modified outside of vim.
set shiftround                 " Round shifting off to multiples of shiftwidth
filetype plugin on             " Enable filetype detection
syntax on                      " Syntax highlighting? Hell yes.
set tabstop=4 shiftwidth=4 softtabstop=4    " Set default indent level to 4
set autoindent                 " Autoindent is nice.
set expandtab                  " I don't want tabs, I want spaces
set smartindent                " Smartindent is awfully necessary


" Make Ctrl-Backspace do what I'm used to (erase entire word)
imap <c-bs> <c-w>
imap <c-del> <c-w>

" Do indenting with Tab and Shift-Tab like I'm used to in a regular IDE,
" keeping the lines selected.
vmap <Tab>   >gv
vmap <S-Tab> <gv
nmap <Tab>   <S-V><Tab>
nmap <S-Tab> <S-V><S-Tab>
imap <S-Tab> <ESC><S-Tab>

" ****************************************
" **  Searching
" ****************************************

set incsearch                    " Search incrementally.
set ignorecase                   " Ignore case when searching.
set smartcase                    " Except when a mix of case is given.
set hlsearch                     " Highlight search hits

" ****************************************
" **  Navigation
" ****************************************

" Pressing up in a long line gets you to the above line "in the screen", etc.
noremap j gj
noremap k gk

" Learn you a keyboard movement for great good!
nmap <Up> :echo "Nope, use K stead of /\\!"<CR>
nmap <Down> :echo "Nope, use J instead of \\/!"<CR>
nmap <Left> :echo "Nope, use H instead of <-!"<CR>
nmap <Right> :echo "Nope, use L instead of ->!"<CR>

" ****************************************
" **  Formatting
" ****************************************

" Reflow a block of text with Ctrl-Y.
nmap <C-Y> gqap
imap <C-Y> <ESC>gqap
vmap <C-Y> gq

" Do default formatting, but also don't autoformat while I'm inserting (l)
set formatoptions=tcql

" ****************************************
" **  Saving files
" ****************************************

" Backup and swap files are annoying
set nobackup
set noswapfile

" Save with Ctrl-S (and Cmd-S on the Mac) cause that's a reflex for me
nmap <C-S> :w<CR>
vmap <C-S> <ESC><C-S>gv
imap <C-S> <ESC><C-S>
if has("mac")
    nmap <D-S> :w<CR>
    vmap <D-S> <ESC><D-S>gv
    imap <D-S> <ESC><D-S>
endif
