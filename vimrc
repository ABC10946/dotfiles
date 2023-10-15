set title
" set smartindent
set autoindent
syntax enable
nnoremap <silent><C-t>   :tabe<CR>
nnoremap <silent><C-w>   :tabn<CR>
nnoremap <silent><Tab>   :wincmd w<CR>
nnoremap <silent><C-e>   :NERDTreeToggle<CR>

" plugin section
call plug#begin('$HOME/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddc-ui-native'
" Install your sources
Plug 'Shougo/ddc-around'
" Install your filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
Plug 'airblade/vim-gitgutter'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
call plug#end()

set visualbell t_vb=

set mouse=a
set clipboard&
set clipboard^=unnamedplus
set backspace=indent,eol,start

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', #{
      \ around: #{mark: 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \ around: #{maxSize: 500},
      \ })

" Customize settings on a filetype
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', #{
      \ clangd: #{mark: 'C'},
      \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', #{
      \ around: #{maxSize: 100},
      \ })

" Mappings
"
" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()

set number
set updatetime=100

packadd termdebug

set list
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
hi NonText    ctermbg=None ctermfg=59 guibg=NONE guifg=None
hi SpecialKey ctermbg=None ctermfg=59 guibg=NONE guifg=None
