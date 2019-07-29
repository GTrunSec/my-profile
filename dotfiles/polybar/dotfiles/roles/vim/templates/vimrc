"pathogen
execute pathogen#infect()

" lines numbers
" set nu
syntax on
filetype plugin indent on
set background=dark
set mouse=r
set ruler		" show the cursor position all the time
set autoindent		" always set autoindenting on
set wildmenu

" tab 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" brackets highlight color
autocmd VimEnter,Colorscheme * :hi MatchParen cterm=none ctermbg=white ctermfg=black

" remember last cursor place
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" powerline
set laststatus=2
set t_Co=256
let g:powerline_pycmd="py3"
{% if ansible_os_family == "FreeBSD" %}
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/
{% endif %}
