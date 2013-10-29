" File ~/.vim/ftplugin/python.vim
" ($HOME/vimfiles/ftplugin/python.vim on Windows)
" Python specific settings.
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smarttab
set formatoptions=croql

"Run code
nnoremap <Leader>p :!python2 %<Cr>
nnoremap <Leader>P :!python %<Cr>

" Use flake8
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'
