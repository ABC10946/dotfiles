set title
set smartindent
set autoindent
syntax enable
nnoremap <silent><C-t>   :tabe<CR>
nnoremap <silent><C-w>   :tabn<CR>
nnoremap <silent><Tab>   :wincmd w<CR>
nnoremap <silent><C-e>   :NERDTreeToggle<CR>
set tabstop=4
set shiftwidth=4
set expandtab
set number

" plugin section
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
call plug#end()
