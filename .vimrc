" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Install Locally for linting:
"
" yarn add --dev eslint babel-eslint eslint-plugin-react 
" eslint --init 
"
" vim-plug config
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/openssl.vim'
Plug 'tpope/vim-sensible'
" Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'davidhalter/jedi-vim'
Plug 'mxw/vim-jsx'
Plug 'Shutnik/jshint2.vim'
Plug 'tpope/vim-commentary'
Plug 'rstacruz/sparkup'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'jamessan/vim-gnupg'
Plug 'Valloric/YouCompleteMe' 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' 
Plug 'skywind3000/asyncrun.vim' 
Plug 'w0rp/ale'
Plug 'tpope/vim-sleuth'
Plug 'ap/vim-css-color'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-syntastic/syntastic'

call plug#end()

command! -nargs=0 Prettier :ALEFix prettier

" Turns off linting besides on save
let g:ale_lint_on_text_changed = 'never'

" Turns off annoying help window from youcompleteme
set completeopt-=preview

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
" Removed jml 5/23/18 - annoying as shit
" set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
vnoremap // y/<C-R>"<CR>
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

" React Stuff
let g:jsx_ext_required = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ! gets rid of command already exists error when sourcing
command! Nt NERDTree
command! NTF NERDTreeFind

" Allow sparkup to be used in jsx files
autocmd FileType javascript.jsx runtime! ftplugin/html/sparkup.vim
"----------------------------------------------------------
" fzf config JML
"----------------------------------------------------------
command! Ls Buffers
function! s:find_git_root()
      " let rootDir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
      " return (rootDir ? rootDir : '~/')
      return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! s:find_local_git_root()
      :lcd %:p:h
      return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

fun! ExactSearch()
    :call fzf#vim#gitfiles('.', {'options': ['--query', "'"]})
endfun

if executable("fzf")
    let g:fzf_layout = { 'down': '~30%' }
        let g:fzf_action = {
                  \ 'ctrl-x': 'split',
                  \ 'ctrl-t': 'tab split',
                  \ 'ctrl-v': 'vsplit',
                  \ }
        nnoremap <C-p> :call FzfOmniFiles()<CR>
        " nnoremap <C-e> :call ExactSearch()<CR>
        nnoremap <c-p> :FZF<cr>

    command! GZF execute 'Files' s:find_git_root()
    nnoremap <silent> <C-P> :<C-u>GZF<CR>
endif
command! -nargs=* Cd call fzf#run(fzf#wrap( {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',  'sink': 'cd'}))
command! -nargs=* -complete=dir Cdd call fzf#run({'source': 'find '.s:find_local_git_root().' -type d','sink': 'cd','down':'20%'})
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)


let g:fzf_history_dir = '~/.local/share/fzf-history'

"----------------------------------------------------------
" fzf config end JML
"----------------------------------------------------------

"----------------------------------------------------------
" vim-go config
"---------------------------------------------------------- 
let g:go_fmt_command = "goimports"         
let g:go_auto_type_info = 1                
"----------------------------------------------------------
" vim-go config end
"----------------------------------------------------------

