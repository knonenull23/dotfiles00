set nocompatible 
set showmatch
set ignorecase
set mouse=v
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set noswapfile
set backupdir=~/.cache/vim
set ttyfast
set wildmode=longest,list
set clipboard+=unnamedplus
filetype plugin on

" guard for distributions lacking the 'persistent_undo' feature.
if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
 Plug 'dracula/vim'
 Plug 'preservim/nerdtree'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-commentary'
call plug#end()

colorscheme dracula
syntax on

let mapleader="\\"
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fc :Commits<CR>
nnoremap <Leader>fg :Rg
nnoremap <Leader>fG :RG
nnoremap <Leader>ft :Tags

nnoremap <Leader><Leader> :set number! \| :noh<CR>
nnoremap <Leader>q :NERDTreeToggle<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-h> <C-W>h
nnoremap <A-l> <C-W>l
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 :tablast<cr>
