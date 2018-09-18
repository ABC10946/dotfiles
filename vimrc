set smartindent
set autoindent
syntax enable
nnoremap <silent><C-e>   :tabe<CR>
nnoremap <silent><C-w>   :tabn<CR>
nnoremap <silent><Tab>  :wincmd w<CR>

" plugin section
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
call plug#end()
