" File system options:
set autoread                " Automatically restart files changed by other programs
set noswapfile              " Do not create exchange files

" Sound signal options:
set noerrorbells            " Disconnect the sound signals of errors
set visualbell              " Use a visual signal instead of a sound

" Display options:
set number                  " Show the lines
set numberwidth=3           " The width of the column number
set nowrap                  " Disconnect the transfer of lines
set showcmd                 " Show on the command line we dial the command
set tabstop=4               " Stage width in spaces
set shiftwidth=4            " Speaking width when using stalie

" Save options:
set history=1000            " Store 1000 teams in history
set nobackup                " Do not create backups of files
set nowritebackup           " Do not create backups of files before saving

" Options of syntactic backlight and automatic formatting:
syntax on                   " Turn on syntactic backlight
filetype plugin indent on   " Enable automatic defining the file type and the use of appropriate options

" Lightline -- https://github.com/itchyny/lightline.vim
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

