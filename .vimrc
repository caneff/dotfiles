" Vundle -- the Right Way to manage Vim plugins ---------------------------{{{1:
"
" Stolen mainly from chiphogg/dotfiles
"
" Opening boilerplate --------------------------------------------------{{{2
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle ---------------------------------------------{{{2
" Required
Plugin 'gmarik/Vundle.vim'
" ----------------------------------------------------------------------}}}2

" Vim enhancements
Plugin 'bling/vim-airline'
Plugin 'candycode.vim'

" Personal Plugins
Plugin 'DeleteTrailingWhitespace'
Plugin 'SirVer/ultisnips'
Plugin 'bufexplorer.zip'
Plugin 'lokaltog/vim-easymotion'
" Plugin 'kana/vim-arpeggio'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'matchit.zip'
" Plugin 'oblitum/rainbow'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'wikitopian/hardmode'
Plugin 'xolox/vim-misc'
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}

" " Text Objects
" Needed for others
Plugin 'kana/vim-textobj-user'

Plugin 'Julian/vim-textobj-brace'
Plugin 'Julian/vim-textobj-variable-segment'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-fold'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-line'
Plugin 'kana/vim-textobj-syntax'
Plugin 'sgur/vim-textobj-parameter'
Plugin 'thinca/vim-textobj-between'

" R plugin
"
" "Needed for R-plugin
Plugin 'jalvesaq/VimCom'
Plugin 'jcfaria/Vim-R-plugin'

call vundle#end()
filetype plugin indent on    " required for vundle (and generally a good idea!)

" Basic settings ----------------------------------------------------------{{{1

" ',' is easy to type, so use it for <Leader> to make compound commands easier:
let mapleader=","
" Unfortunately, this introduces a delay for the ',' command.  Let's compensate
" by introducing a speedy alternative...
noremap ,. ,

" Improving basic commands ---------------------------------------------{{{2
" Easy quit-all, which is unlikely to be mistyped.
nnoremap <silent> <Leader>qwer :confirm qa<CR>

" Y should work like D and C.
nnoremap Y y$

" <C-U> can delete text which undo can't recover. These mappings prevent that.
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Some filetypes work best with 'nowrap'.  Vim moves left and right using zL
" and zH, but this is awkward.  ZL and ZH are easier alternatives.
nnoremap ZL zL
nnoremap ZH zH

" Windows, tabs, and buffers -------------------------------------------{{{2

" Let vim hide unsaved buffers.
set hidden

" Resize splits when a new split gets made. Good with tiling WMs.
set equalalways
autocmd VimResized * if &equalalways | wincmd = | endif

" Text formatting ------------------------------------------------------{{{2

" 80 characters helps readability.
set textwidth=80

" Experience shows: tabs *occasionally* cause problems; spaces *never* do.
" Besides, vim is smart enough to make it "feel like" real tabs.
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab

" Format options (full list at ":help fo-table"; see also ":help 'fo'")
" Change between += and -= to toggle an option
set fo -=t  " Don't auto-wrap text...
set fo +=c  " ...or comments; I believe this is causing epic E323/E316 errors
            " with easytag.vim (and possibly others).
set fo +=q  " Let me format comments manually.
set fo +=r  " Auto-continue comments if I'm still typing away in insert mode,
set fo -=o  "  but not if I'm coming from normal mode (I find this annoying).
set fo +=n  " Handle numbered lists properly: a lifesaver when writing emails!
set fo +=j  " Be smart about comment leaders when joining lines.


" Almost every filetype is better with autoindent.
" (Let filetype-specific settings handle the rest.)
set autoindent

" I have no idea why you would want this.
set conceallevel=0

" Folding --------------------------------------------------------------{{{2
"
" Fold Focusing
" Close all folds, and open only enough to view the current line
nnoremap <Leader>z zMzv
" Go up (ZK) and down (ZJ) a fold, closing all other folds
nnoremap ZJ zjzMzv
nnoremap ZK zkzMzv

" Disable ZZ quit command. Use :qa instead
nnoremap ZZ <Nop>

" Show 1 column of folding info
set foldcolumn=1

" Miscellaneous settings -----------------------------------------------{{{2

" When would I ever *not* want these?
set number   " Line numbers
syntax on    " syntax highlighting
set showcmd  " Show partial commands as you type

" Occasionally useful, but mainly too annoying.
set nohlsearch

set cmdheight=3 " I like more room in my command window for errors and the like

set colorcolumn=81,82

" Command line history: the default is just 20 lines!
set history=10000

" Disable the bell
set noeb vb t_vb=

set background=dark
colorscheme candycode

" Don't litter directories with swap files; stick them all here.
set directory=~/.vimswp

" Put a statusline for *every* window, *always*.
set laststatus=2

" Show line and column number.
set ruler

" Soft-wrapping is more readable than scrolling...
set wrap
" ...but don't break in the middle of a word!
set linebreak

"Esc is too far away
inoremap jk <Esc>
inoremap <Esc> <nop>

" gvim options
set guioptions-=m  "remove menu bar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=T  "remove toolbar

set wildmode=longest,list,full  " Completion modes for wildcard expansion
set showmode                    " Show the mode you're currently in
set showmatch                   " Show matching braces / brackets
set title                       " Let vim change my tab/window title
set infercase                   " when searching, decide if case-sensitive based on if you include uppercase
set ignorecase smartcase
set expandtab
set tabstop=2
set nowrap
set softtabstop=2
set list                " show the non-printing characters in 'listchars'

" Set characters for trailing spaces and for tabs. Make their color lime green
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
highlight NonText guifg=#00ff00
highlight SpecialKey guifg=#00ff00

" cd to the current directory for each file
au BufEnter * silent! lcd %:p:h

" Turn off tab highlighting in go
au BufRead,BufNewFile *.go set nolist

" Installation instructions:
" https://github.com/powerline/fonts
set guifont=Inconsolata\ for\ Powerline\ 16

let g:omni_sql_no_default_maps = 1

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

" Save every time vim loses focus.
au FocusLost * :wa

" Navigate windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open a new vertical split and move over to it
nnoremap <Leader>v <C-w>v<C-w>l

" The case changing always gets me in trouble in visual mode.
vnoremap u <Nop>
vnoremap U <Nop>
vnoremap ~ <Nop>

" Add a shortcut to enter a newline and go right back to normal mode.
nnoremap K li<cr><esc>

" An attempt to format R code faster
function FixR()
  %s/,\([^ ]\)/, \1/gec
  %s/\([^ ]\)+/\1 +/gec
  %s/+\([^ ]\)/+ \1/gec
  %s/\([^ <(]\)-/\1 -/gec
  %s/ -\([^ ]\)/ - \1/gec
  %s/\([^ ]\)\*/\1 */gec
  %s/\*\([^ ]\)/* \1/gec
  %s/\([^ ]\):=/\1 :=/gec
  %s/:=\([^ ]\)/:= \1/gec
  %s/\([^ ]\)&/\1 &/gec
  %s/&\([^ ]\)/& \1/gec
  %s/\([^ ]\)==/\1 ==/gec
  %s/==\([^ ]\)/== \1/gec
  %s/\([^ ]\)||/\1 ||/gec
  %s/||\([^ ]\)/|| \1/gec
  %s/\([^ ]\)|/\1 |/gec
  %s/|\([^ ]\)/| \1/gec
endfunction

nnoremap ,fr :call FixR()<CR>
" Go Stuff ---------------------------------------------------------{{{1
"
" 1. General stuff.
au BufEnter *.go set shiftwidth=2 noexpandtab tabstop=2

" Set Fmt to use goimports
let g:gofmt_command='goimports'

" Run gofmt before saving file
" autocmd BufWritePre <buffer> :keepjumps Fmt

" Only fold the first level for go, as much isn't nested.
autocmd Filetype go setlocal foldmethod=syntax
autocmd Filetype go setlocal foldnestmax=1


" Plugin settings ---------------------------------------------------------{{{1

" Airline -------------------------------------------------------------{{{2
"
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1

" Ctrlp  -------------------------------------------------------------{{{2
"
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn\|\.git5_specs$\|review$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'blaze-bin\|blaze-genfiles\|blaze-google3\|blaze-out\|blaze-testlogs\|READONLY$',
  \ }

" Show hidden files.
let g:ctrlp_show_hidden = 1

let g:ctrlp_follow_symlinks = 1

" DeleteTrailingWhitespace -------------------------------------------------------------{{{2

let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'


" Easymotion-------------------------------------------------------------{{{2

map <Leader> <Plug>(easymotion-prefix)
omap <SPACE> <Plug>(easymotion-s)
nmap <SPACE> <Plug>(easymotion-s)

"let g:EasyMotion_special_select_phrase = 1
" let g:EasyMotion_special_select_line = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_skipfoldedline = 0
" let g:EasyMotion_special_mapping_l = 'l'
" let g:EasyMotion_special_mapping_p = 'p'


" Hard Mode  -------------------------------------------------------------{{{2

" Enable Hard Mode by default
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Toggle Hard Mode.
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
let g:HardMode_level='wannabe'

" NERD Commenter -------------------------------------------------------------{{{2
"
" Have a space separate the comment character and the text.
let g:NERDSpaceDelims = 1

" Rainbow --------------------------------------------------------------{{{2
" au FileType c,cpp,objc,objcpp,go,r,vim,szl,java call rainbow#load()
" Syntastic ------------------------------------------------------------{{{2

" Not sure why I'd ever want my syntax checked when I'm quitting...
let g:syntastic_check_on_wq = 0

" Fix goroot complaints
let g:syntastic_go_checkers = ['gofmt', 'golint', 'gotype', 'govet']


" Ultisnip  -------------------------------------------------------------{{{2
"
" Make ultisnip keys not conflict with YCM
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" Vim-R-Plugin  -------------------------------------------------------------{{{2
"

let vimrplugin_show_args = 1

" Don't expand _ into <-.
let vimrplugin_assign = 0

" Enable syntax folding.
let r_syntax_folding = 1
autocmd Filetype r setlocal foldnestmax=1

" Line things up with opening braces.
let r_indent_align_args = 1

" YouCompleteMe  -------------------------------------------------------------{{{2

" Comments and strings are fair game for autocompletion.
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_comments_and_strings = 1

" Pop up a preview window with more info about the selected autocomplete option.
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1

" Start autocompleting right away, after a single character!
" let g:ycm_min_num_of_chars_for_completion = 1

" " This gives me nice autocompletion for C++ #include's if I change vim's working
" " directory to the project root.
let g:ycm_filepath_completion_use_working_dir = 1

" " Add programming language keywords to the autocomplete list.
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']

" Vimscript ------------------------------------------------------------{{{2
augroup filetype_vim
  autocmd!
  " Fold based on the triple-{ symbol.  sjl explains why you want this:
  " http://learnvimscriptthehardway.stevelosh.com/chapters/18.html
  autocmd FileType vim setlocal foldmethod=marker
augroup END


" We can put settings local to this particular machine in ~/.vimrc_local
if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif

" let g:tagbar_type_go = {
"     \ 'ctagstype': 'go',
"     \ 'kinds' : [
"         \'p:package',
"         \'f:function',
"         \'v:variables',
"         \'t:type',
"         \'c:const'
"     \]
" \}

