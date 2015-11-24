" This must be first, because it changes other options as a side effect
set nocompatible

" change the mapleader from "\" to ","
let mapleader=","

" change command character from ":" to ";"
nore ; :
nore : ;

" hide buffers instead of closing them
" allows you to have unwritten changes to a file while
" opening a new file
set hidden

set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
set smartindent " automatically indent some files
set expandtab " Tabs should be spaces
" set tab sizes
set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType javascript,ruby,tex,json,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

set number " always show line numbers
set ruler " display line, col position
set cursorline " highlight the line the cursor is on
set cursorcolumn " highlight the column the cursor is on
syntax on

" remap terminal mode exit
tnoremap <Leader>e <C-\><C-n>

set wildmenu " show completion options
set wildmode=longest:full,full
set incsearch " show search matches as you type
set hlsearch " highlight search terms
set ignorecase " ignore cases when searching
set smartcase " but only when the search is all lower case

" set vim to write back and temporary files
" to a central directory (prevents vim
" littering files everywhere
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

"Set up displaying of invisible chars
"scriptencoding utf8
set listchars=eol:\¬,tab:»\ 
set list

" Map CTRL-l to :b#
map <C-L> :b#<cr>

" Plugins - by vim-plug
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc'
Plug 'Shougo/vimfiler'
Plug 'Shougo/unite.vim'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'jpo/vim-railscasts-theme'
Plug 'chase/vim-ansible-yaml'
Plug 'tomasr/molokai'
Plug 'sheerun/vim-polyglot'
"Plug 'kchmck/vim-coffee-script'
"Plug 'avakhov/vim-yaml'
Plug 'tpope/vim-surround'

call plug#end()

" Unite
call unite#custom#profile('default', 'context', {'no_split':1, 'resize':0})
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :<C-u>Unite file file_rec/async:!<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap <leader>e :<C-u>Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=grep grep:.<cr>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Shift+Tab decreases indentation (insert mode)
inoremap <S-Tab> <Esc><<i

" Open files at last location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" ESC vs <c-c> who knows
imap <c-c> <esc>

" clear search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

colorscheme molokai
let g:rehash256 = 1
let g:molokai_original = 1

filetype plugin indent on
autocmd FileType yaml setl indentkeys-=<:>
autocmd FileType ansible setl indentkeys-=<:>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1
let g:syntastic_php_phpcs_exec = '/Users/boggs/.composer/vendor/bin/phpcs'
let g:syntastic_css_phpcs_exec = '/Users/boggs/.composer/vendor/bin/phpcs'
let g:syntastic_ruby_rubocop_exec = '/usr/local/bin/rubocop'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]
let g:syntastic_css_checkers = ['prettycss']
