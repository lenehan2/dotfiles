" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
 
"------------------------------------------------------------
    " Features {{{1
    "
    " These options and commands enable some very useful features in Vim, that " no user should have to live without.
     
    " Set 'nocompatible' to ward off unexpected things that your distro might
    " have made, as well as sanely reset options when re-sourcing .vimrc
    set nocompatible
    filetype off

    " Attempt to determine the type of a file based on its name and possibly its
    " contents. Use this to allow intelligent auto-indenting for each filetype,
    " and for plugins that are filetype specific.
    filetype indent plugin on
 
" Enable syntax highlighting
syntax on 
 
"------------------------------------------------------------
" Must have options 
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
"
"TypeScript config"
" set filetypes as typescript.tsx
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END 

autocmd FileType html,json,typescript.tsx setlocal shiftwidth=2 tabstop=2

" augroup MyWebpackAUGroup
"   au! BufRead,BufNewFile,BufEnter *webpack.js,*webpack*.js setlocal shiftwidth=2 tabstop=2
" augroup END
 
" TODO
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
vnoremap // y/<C-R>"<CR> 
" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Rendering
set ttyfast

" Last line
set showmode
set showcmd
" TODO remove?
set showmatch
set matchpairs+=<:> " use % to jump between pairs
" JML added from old vimrc
set encoding=utf-8
set formatoptions=tcqrn1

" JML added - more natural split opening
set splitbelow
set splitright
"------------------------------------------------------------

runtime macros/matchit.vim

"Syntastic"
"-----------------"
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
"End syntastic"

"JSHint"
"-----------"
" let JSHintUpdateWriteOnly=1
"End JSHINT"
"

let g:NERDTreeNodeDelimiter = "\u00a0"
" No longer using Ale, using coc entirely - JML
" Ale js lint fixing
" let g:ale_fixers = {
" \   'javascript': ['eslint'],
" \   'typescript': ['eslint'],
" \}

" let eslintFile = findfile('.eslintrc', '.;') != '' ||  findfile('.eslintrc.js', '.;') != '' || findfile('eslint.config.js', '.;') != ''  
" autocmd FileType javascript,typescript.tsx let g:ale_linters = eslintFile ? {'javascript': ['eslint'], 'typescript': ['eslint']} : {'javascript': ['']}

 " Write this in your vimrc file
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
"  " " You can disable this option too
"  " " if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0
" let g:ale_disable_lsp = 1


"----------------------------------------------------------
" Vim-Plug plugins JML
"----------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible' " standard vim configurations
" Plug 'kien/ctrlp.vim' " fzf does similar, but allows for <C p> <C r> for
" exact matches, may not be necessary if using fzf though
Plug 'pangloss/vim-javascript' " javascript syntax highlighter
" Plug 'ianks/vim-tsx' " May be unecessary with typescript-vim
Plug 'leafgarland/typescript-vim' " Typescript syntax highligher
Plug 'peitalin/vim-jsx-typescript' " JSX in TS file syntax highlighter
Plug 'MaxMEllon/vim-jsx-pretty' "React syntax highlighting and indenting plugin for vim. Also supports the typescript tsx file
" Plug 'Shutnik/jshint2.vim' " JSHint library, not currently using jshint
" though
Plug 'neoclide/coc.nvim', {'branch': 'release'} " TypeScript IDE functionality
Plug 'tpope/vim-commentary' " Comment via gc and gcc
Plug 'rstacruz/sparkup' " HTML tag completion with <C-e>
Plug 'scrooloose/nerdtree' " File tree searcher 
Plug 'tpope/vim-surround' " Surround text with any key (\"\'\<{,etc) 
Plug 'tpope/vim-fugitive' " Git library for vim, not used often
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'w0rp/ale' " Used for linting, not currently setup  
Plug 'altercation/vim-colors-solarized' 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzzy file searcher
Plug 'junegunn/fzf.vim' " Fuzzy file search
Plug 'ap/vim-css-color' " display color for css colors   
Plug 'henrik/vim-indexed-search' " adds At match #N out of M matches to vim searches
Plug 'jamessan/vim-gnupg' " gpg encrypt/decrypt files 
Plug 'MarcWeber/vim-addon-mw-utils' " ???
Plug 'tomtom/tlib_vim'
" Plug 'ervandew/snipmate.vim' " cool snippets library, not used though
Plug 'ervandew/supertab' 
call plug#end() 

filetype plugin indent on

"----------------------------------------------------------
" Vim-Plug end
"----------------------------------------------------------


"Colorscheme
syntax enable
set background=dark
colorscheme hybrid_material
"Colorscheme end

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g ""'

" NERDTree config JML
let g:NERDTreeDirArrows=0
command! Nt NERDTree
command! NTF NERDTreeFind
" NERDTree end

autocmd FileType html set omnifunc=htmlcomplete#CompleteTag
set foldmethod=syntax
set foldlevel=20


" Allow sparkup to be used in jsx files
autocmd FileType javascript.jsx,typescript.tsx runtime! ftplugin/html/sparkup.vim

" :Bs filename
"  [1]- filename_test.txt
"  [2]- other_filename_test.txt
"  select buffer
"
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")



"----------------------------------------------------------
" fzf config JML
"----------------------------------------------------------
command! Ls Buffers 
function! s:find_git_root()
      " let rootDir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
      " return (rootDir ? rootDir : '~/')
      return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
function! s:find_cwd()
      " let rootDir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
      " return (rootDir ? rootDir : '~/')
      return system('pwd')[:-2]
endfunction

function! s:find_local_git_root()
      :lcd %:p:h
      return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

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
	nnoremap <C-e> :call ExactSearch()<CR>

    command! GZF execute 'Files' s:find_git_root()
    command! GZFT execute 'Files' s:find_cwd()
    nnoremap <silent> <C-P> :<C-u>GZF<CR>
    nnoremap <C-I> :<C-u>GZFT<CR>
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
" fzf config end 
"----------------------------------------------------------
"
"RANDOM SHIT FROM OLD VIMRC "
set modelines=0
set wrap
set textwidth=79
set noshiftround
set scrolloff=3
let mapleader = '\'
vnoremap // y/<C-R>"<CR> 
" map <leader><space> :let @/=''<cr> " clear search
" inoremap <F1> <ESC>:set invfullscreen<CR>a
" nnoremap <F1> :set invfullscreen<CR>
" vnoremap <F1> :set invfullscreen<CR>
" map <leader>q gqip
" set listchars=tab:▸\ ,eol:¬
" map <leader>l :set list!<CR> " Toggle tabs and EOL

"----------------------------------------------------------
" vim debugging
"----------------------------------------------------------
function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction 

" augroup sparkup_types
"   autocmd!
"   " Add sparkup to new filetypes
"   autocmd FileType html,javascript.jsx,typescript.tsx,javascript,must runtime! ftplugin/ftplugin/html/sparkup.vim
" augroup END

" coc config
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-json', 
  \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Rename symbol.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

set updatetime=300

" END coc config
