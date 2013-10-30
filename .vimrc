" Vundle -- the Right Way to manage Vim plugins ---------------------------{{{1
"
" Stolen mainly from chiphogg/dotfiles
"
" Opening boilerplate --------------------------------------------------{{{2
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle ---------------------------------------------{{{2
" Required
Bundle 'gmarik/vundle'
" ----------------------------------------------------------------------}}}2

" Vim enhancements
Bundle 'bling/vim-airline'
Bundle 'candycode.vim'



" Personal Plugins
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-unimpaired'

" R plugin
"
" "Needed for R-plugin
Bundle 'jalvesaq/VimCom'
Bundle 'jcfaria/Vim-R-plugin'

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

" Text formatting ------------------------------------------------------{{{2

" 80 characters helps readability.
set textwidth=80

" Highlight lines which are too long
set colorcolumn=+1

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

" Almost every filetype is better with autoindent.
" (Let filetype-specific settings handle the rest.)
set autoindent


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

set foldcolumn=1
" Miscellaneous settings -----------------------------------------------{{{2

" When would I ever *not* want these?
set number   " Line numbers
syntax on    " syntax highlighting
set showcmd  " Show partial commands as you type
set cmdheight=3


set colorcolumn=81,82

" Command line history: the default is just 20 lines!
set history=500

" Disable the bell
set noeb vb t_vb=

set background=dark
colorscheme candycode

" Don't litter directories with swap files; stick them all here.
set directory=~/.vimswp

" Put a statusline for *every* window, *always*.
set laststatus=2

set ruler

" Soft-wrapping is more readable than scrolling...
set wrap
" ...but don't break in the middle of a word!
set linebreak

"Esc is too far away
imap ;; <Esc>

set wildmode=longest,list,full  " Completion modes for wildcard expansion
set hlsearch                    " Highlight previous search results
set showmode                    " Show the mode you're currently in
set showmatch                   " Show matching braces / brackets
set title                       " Let vim change my tab/window title
set infercase                   " when searching, decide if case-sensitive based on if you include uppercase
set ignorecase smartcase
set ttimeoutlen=10      " milliseconds awaited for a multi-stroke key combination to comlete
set expandtab
set tabstop=2
set nowrap
set softtabstop=2
set list                " show the non-printing characters in 'listchars'
execute "set listchars=trail:".nr2char(9679).",tab:".nr2char(187).nr2char(183).",extends:".nr2char(187).",precedes:".nr2char(171)

au BufEnter * silent! lcd %:p:h

" Turn off tab highlighting in go
au BufRead,BufNewFile *.go set nolist

" Installation instructions:
" https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
set guifont=Inconsolata\ for\ Powerline\ 13

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

" Go Stuff ---------------------------------------------------------{{{1
"
" 1. General stuff.
au BufEnter *.go set shiftwidth=2 noexpandtab tabstop=2
au BufEnter *.go map <F2> :cprev<CR>
au BufEnter *.go map <F3> :cnext<CR>

" 2. Map gofmt to ^O.  Walk through any syntax errors caught by gofmt.
function FormatGoProgram()
  let cursor_position = getpos(".")
  silent exe "%!/usr/lib/google-golang/bin/gofmt 2>/tmp/go.$USER.err"
  if v:shell_error
    undo
  endif
  call setpos('.', cursor_position)
  silent exe "!sed --in-place -n 's/<standard input>/%/p' /tmp/go.$USER.err"

  let w = winnr()       " Remember window number.
  cf /tmp/go.$USER.err  " Pick up any errors from this file.
  cwindow 3             " Open a 3-line window for errors, or close it if none.
  " Switch back to the original window.
  exe w . "wincmd w"
  redraw!
  echo "Formatted"
endfunction
au BufEnter *.go map <C-o> :call FormatGoProgram()<CR>
"autocmd BufWritePre *.go :silent call FormatGoProgram()
autocmd FileType go autocmd BufWritePre <buffer> execute "normal! mz:mkview\<esc>:silent call FormatGoProgram()\<esc>:loadview\<esc>`z"
au BufLeave *.go unmap <C-o>

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


" NERD Commenter -------------------------------------------------------------{{{2
"
" Have a space separate the comment character and the text.
let g:NERDSpaceDelims = 1

" NERD Tree -------------------------------------------------------------{{{2
"
" NERD shortcut
nnoremap <Leader>/ :NERDTreeToggle<CR>

" Ultisnip  -------------------------------------------------------------{{{2
"
" Make ultisnip keys not conflict with YCM
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" Vim-R-Plugin  -------------------------------------------------------------{{{2
"
let vimrplugin_conqueplugin = 0
let vimrplugin_conquevsplit = 0

let vimrplugin_term_cmd = "gnome-terminal --title R --geometry=100x50-20+0 -e"
let g:vimrplugin_screenplugin = 0

" Don't expand _ into <-.
let vimrplugin_underscore = 0

" Don't line things up with opening braces.
let r_indent_align_args = 0


" YouCompleteMe  -------------------------------------------------------------{{{2

" Comments and strings are fair game for autocompletion.
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_comments_and_strings = 1

" Pop up a preview window with more info about the selected autocomplete option.
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 0

" Start autocompleting right away, after a single character!
let g:ycm_min_num_of_chars_for_completion = 1

" This gives me nice autocompletion for C++ #include's if I change vim's working
" directory to the project root.
let g:ycm_filepath_completion_use_working_dir = 1

" Add programming language keywords to the autocomplete list.
let g:ycm_seed_identifiers_with_syntax = 1

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

