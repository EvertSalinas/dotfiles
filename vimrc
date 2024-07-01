" Plugins ---{{{
" " PlugUpdate
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-test/vim-test'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm'
Plug 'Raimondi/delimitMate'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'joshdick/onedark.vim'
Plug 'ThePrimeagen/vim-be-good'
call plug#end()

let g:rspec_command = "Dispatch bundle exec rspec -I . {spec}"

" Basic settings ---{{{
" Leader
let mapleader = " "
let maplocalleader = " "

" Use Vim settings, rather than Vi settings (much better!).
" " This must be first, because it changes other options as a side effect.
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set incsearch " Enable incremental search
set hlsearch " Enable highlight search
set splitbelow " Always split below
set mouse=a
set number relativenumber
" Write swp files to /tmp instead of current directory
set swapfile
set dir=/tmp
set encoding=UTF-8

" Make it obvious where 100 characters is
" highlight ColorColumn ctermbg=18
set textwidth=100

" lightline
set noshowmode

set cursorline

" Ale (Linting)
let b:ale_fixers = {'ruby': ['standardrb'], 'rust': ['rustfmt'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '>>'

" Open fzf
" nmap <Leader>p :Files<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Vim.test mappings
nmap <silent> <Leader>s :TestNearest<CR>
nmap <silent> <Leader>t :TestFile<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>g :TestVisit<CR>

let test#strategy = 'neovim'

" Colorscheme
syntax on
set t_Co=256
" Enable true colors if available
set termguicolors
colorscheme onedark
" highlight Comment cterm=italic gui=italic

hi LineNr ctermfg=250 ctermbg=234
hi Normal guibg=NONE ctermbg=NONE


"" Font
set guifont=Monaco

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
" }}}

" Silver Searcher ---{{{
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in fzf for listing files. Lightning fast and respects .gitignore
    let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

    if !exists(":Ag")
        command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Ag<SPACE>
    endif
endif

" NERDTree
let NERDTreeShowBookmarks = 1   " Show the bookmarks table
let NERDTreeShowHidden = 1      " Show hidden files
let NERDTreeShowLineNumbers = 0 " Hide line numbers
let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
let NERDTreeWinPos = "left"     " Panel opens on the left side
let NERDTreeWinSize = 31        " Set panel width to 31 columns

" Ruby
" Set the Ruby filetype for a number of common Ruby files without .rb
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby

"Autocommands ----{{{
augroup VimResize
    autocmd VimResized * :wincmd =
augroup END

" How can I open a NERDTree automatically when vim starts up if no files were
" specified?
augroup NERDTree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

" strip trailing whitespace on save
augroup TrimWhite
    autocmd BufWritePre * :%s/\s\+$//e
augroup END
"}}}
