" SETUP "

set nocompatible       " disable compatibility to old-time vi

" MOUSE "
set mouse=a

set clipboard=unnamedplus

" APPEARANCE "
set cursorline        " highlight current cursor line
set ttyfast           " Speed up scrolling in Vim
set number            " add line numbers
set cc=88             " set a column border for good coding style
set termguicolors     " better colours

" STATUSLINE "
" This is now handled in a separate file statusline.vim

" TABS "
set tabstop=2              " number of columns occupied by a tab
set softtabstop=2          " see multiple spaces as tab-stops so <BS> does the right thing
set expandtab              " converts tabs to white space
set shiftwidth=2           " width for auto-indents
set autoindent             " indent a new line the same amount as the line just typed

" TYPING "
set backspace=indent,eol,start  " more powerful backspacing

" SEARCHING "
set showmatch              " show matching brackets etc.
set ignorecase             " case insensitive
set smartcase              " match capital letters
set hlsearch               " highlight search
set incsearch              " incremental search

" MENU "
set wildmenu               " show menu of completions
set wildmode=full          " get bash-like tab completions
set wildoptions=tagfile    " show menu above as fuzzy single line

" SYNTAX "
" set spell                  " Set spellcheck on by default
filetype on                " When opening a file try to recognise the filetype
filetype plugin on         " 
filetype indent on         " allow auto-indenting depending on file type
syntax enable              " syntax highlighting (enable to preserve colorscheme, on to override)
