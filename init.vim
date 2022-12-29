call plug#begin()
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'sbdchd/neoformat'
    Plug 'nvim-lua/plenary.nvim' 
    "fuzzy finder
    Plug 'nvim-telescope/telescope.nvim',{'tag':'0.1.0'} 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'dyng/ctrlsf.vim'
    " Git
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    " Completion / linters / formatters
    Plug 'plasticboy/vim-markdown'
    " color scheme
    Plug 'morhetz/gruvbox'
    Plug 'rockerBOO/boo-colorscheme-nvim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release'  }
    Plug 'numToStr/Comment.nvim'
call plug#end()
source $HOME/.config/nvim/general/mappings.vim
"colorscheme gruvbox
colorscheme boo
let g:boo_colorscheme_theme = 'sunset_cloud'
let g:airline_powerline_fonts = 1
let g:neoformat_try_node_exe = 1
let g:airline#extensions#tabline#enabled = 1
let NERDTreeShowHidden=1
"search
"testingggggggggg
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
""""""""""
let g:ctrlsf_backend = 'ack'
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu
filetype plugin indent on
syntax on

"comment
lua require('Comment').setup()
"
"
"
"
" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
set t_Co=256


"colors
" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif
" Create file without opening buffer
function! CreateInPreview()
  let l:filename = input('please enter filename: ')
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  redraw!
endfunction

" Netrw: create file using touch instead of opening a buffer
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction

augroup auto_commands
    autocmd filetype netrw call Netrw_mappings()
augroup END
" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
