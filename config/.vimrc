" Configuration file for Vi Improved, save as ~/.vimrc to use.
" Written on 2014-07-16 by Miko Bartnicki <mikobartnicki@gmail.com>.

" use Vim mode instead of pure Vi, it must be the first instruction
set nocompatible

""" Ryans stuff
" Install Plug if it isn't already. Makes vimrc more portable.
" Install Plug {{{
if !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))
    silent !echo "Plug Plugin manager isn't installed. Installing now. (vim)"
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !echo ""
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if has('nvim') && empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !echo "Plug Plugin manager isn't installed. Installing now. (neovim)"
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !echo ""
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}
"
call plug#begin('~/.vim/bundle')
Plug 'http://github.com/sjl/gundo.vim.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/junegunn/goyo.vim'
Plug 'https://github.com/tpope/vim-dispatch'
Plug 'https://github.com/flazz/vim-colorschemes'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/xolox/vim-notes.git'
Plug 'https://github.com/xolox/vim-misc.git'
" Plug 'https://github.com/jalvesaq/Nvim-R'
" BuildYCM {{{
" function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
"  if a:info.status == 'installed' || a:info.force
"    !./install.py
"  endif
" endfunction
" }}}
" Plug 'https://github.com/Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()

" }}}
" Plugin Configurations {{{
" goyo
nnoremap Y :Goyo<CR>
function! s:goyo_leave()
    source $MYVIMRC
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" vim-easymotion
let mapleader=" "
map <leader><leader>w <Plug>(easymotion-bd-w)
" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" vim-commentary
autocmd FileType matlab,octave setlocal commentstring=%\ %s
" html 2 tab
filetype plugin indent on
" vue 2 tab
autocmd FileType vue set tabstop=2|set shiftwidth=2|set noexpandtab
au BufEnter *.vue set ai sw=2 ts=2 sta et fo=croql
" vim-dispatch
autocmd FileType markdown let b:dispatch = 'pandoc "' . expand("%") . '" -o "' . expand("%:r") . '.pdf"'
" ultisnips
set rtp+=~/.vel/vim/snippets
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=[$HOME."/.vel/vim/snippets"]
let g:UltiSnipsSnippetDir=$HOME.'/.vel/vim/snippets'
let g:UltiSnipsEditSplit="vertical"
" ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion = 3
" vim-easy-align
let g:easy_align_delimiters = {
  \ '%': {
  \       'pattern': '%\+',
  \       'delimiter_align': 'l',
  \       'ignore_groups': ['!Comment']
  \       },
  \ }
" }}}
" Swap, Backup and Undo files {{{
" Note trailing slash to keep full paths in tmp files.

if empty(glob("~/.vim/undo"))
    silent !mkdir -p ~/.vim/undo
endif
if empty(glob("~/.vim/backup"))
    silent !mkdir -p ~/.vim/backup
endif
if empty(glob("~/.vim/swap"))
    silent !mkdir -p ~/.vim/swap
endif

set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

set undofile            " Save undos after file closes
set undolevels=1000     " How many undos
set undoreload=10000    " number of lines to save for undo

" GENERAL {{{

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode
highlight TrailingWhiteSpace ctermbg=red
match TrailingWhiteSpace /\s\+\%#\@<!$/
" colorscheme solarized

set ttyfast
set lazyredraw

" write settings
set confirm " confirm :q in case of unsaved changes
set fileencoding=utf-8 " encoding used when saving file
set nobackup " do not keep the backup~ file

" edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode
set expandtab " fill tabs with spaces
set scrolloff=5 " Keep curser n lines from top/bottom.
set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=4 " set indentation depth to 4 columns
set softtabstop=4 " backspacing over 4 spaces like over tabs
set tabstop=4 " set tabulator length to 4 columns
" set textwidth=100 " wrap lines automatically at 100th column

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ...unless capital letters are used

" file type specific settings
filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code

" syntax highlighting
set background=dark " dark background for console
syntax enable " enable syntax highlighting
set number

" }}}

" Status Line {{{
set laststatus=2
" Left Side:  <mode> | <path> [git branch] [modified]
" Right Side: <size> | <language> <filetype> <encoding> | <percentage> <line number>/<total lines>:<column>
" Mode Dict {{{
let g:currentmode={
    \ 'n'      : 'NORMAL',
    \ 'no'     : 'N-PENDING',
    \ 'v'      : 'VISUAL',
    \ 'V'      : 'V-LINE',
    \ '\<C-V>' : 'V Block',
    \ 's'      : 'SELECT',
    \ 'S'      : 'S-LINE',
    \ '\<C-S>' : 'S-BLOCK',
    \ 'i'      : 'INSERT',
    \ 'R'      : 'REPLACE',
    \ 'Rv'     : 'V-REPLACE',
    \ 'c'      : 'COMMAND',
    \ 'cv'     : 'VIM-EX',
    \ 'ce'     : 'EX',
    \ 'r'      : 'PROMPT',
    \ 'rm'     : 'MORE',
    \ 'r?'     : 'CONFIRM',
    \ '!'      : 'SHELL',
    \ 't'      : 'TERMINAL'
    \}
" }}}

" Buffer Size {{{
let b:buf_size = 0
augroup GetFileSize
  autocmd!
  autocmd BufEnter,BufWritePost * let b:buf_size = FileSize()
augroup END
" Find out current buffer's size and output it.
function! FileSize()
  let bytes = str2float(getfsize(expand('%:p')))
  if bytes <= 0
    return '0'
  endif
  for size in ["B", "K", "M", "G"]
    if (abs(bytes) < 1000)
      return string(float2nr(round(bytes))) . size
    endif
    let bytes = bytes / 1000
  endfor
endfunction
" }}}

" Colors {{{
" 'bg' is text color, 'fg' is the bar colors
hi StatusLine ctermbg=210
hi StatusLine ctermfg=107

hi StatusLineExtra ctermbg=214
hi StatusLineExtra ctermfg=107

hi StatusLineMode ctermfg=020
" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    " Normal Mode
    exe 'hi! StatusLineMode ctermbg=010'
  elseif (mode() =~# '\v(v|V)')
    " Visual Mode
    exe 'hi! StatusLineMode ctermbg=005'
  elseif (mode() ==# 'i')
    " Insert Mode
    exe 'hi! StatusLineMode ctermbg=004'
  else
    " Other Mode
    exe 'hi! StatusLineMode ctermbg=010'
  endif

  return ''
endfunction
" }}}

" Git Info {{{
"
let b:git_branch = ""
augroup GetGitBranch
  autocmd!
  autocmd BufEnter,BufWritePost * let b:git_branch = GitInfo()
augroup END
function! GitInfo()
  let git = system("git -C " . expand('%:p:h') . " rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'")
  if git != ''
    let gitstr = '  ('. git . ')'
    if expand('%:p') != ''
      let gitstr .= ' ' . system('git -C ' . expand('%:p:h') . ' diff --numstat ' . expand('%:p') . " | sed 's/\\([0-9]*\\)\\s*\\([0-9]*\\)\\s.*/\\1(+) \\2(-)/' | tr -d '\n'")
      let gitstr = join(split(gitstr, '\zs')[0:15], '')
    endif
  else
    let gitstr = ''
  endif
  return gitstr
endfunction
" }}}

" Read Only {{{
let b:readonly_flag = ""
augroup ReadOnlyStatus
  autocmd!
  autocmd BufEnter,WinEnter * let b:readonly_flag = ReadOnly()
augroup END
function! ReadOnly()
  if &readonly || !&modifiable
    return '[READ ONLY]'
  else
    return ''
endfunction
" }}}

" File Name {{{
let b:filename = ""
augroup FileName
  autocmd!
  autocmd BufEnter,VimResized * let b:filename = FileName()
augroup END
function! FileName()
    let fullname = expand("%:p")
    if (fullname == "")
        return ' [New]'
    endif
    let remainder = 25 + len(b:git_branch) + len(b:readonly_flag) + len(&filetype) + len(&fenc) + len(g:currentmode[mode()]) + len(b:buf_size)
    if (&columns > len(fullname) + remainder)
        return ' ' . substitute(fullname, $HOME, '~', "")
    elseif (&columns > len(pathshorten(fullname)) + remainder)
        return ' ' . substitute(pathshorten(fullname), '/h/r', '~', "")
    else
        return ' ' . expand("%:t")
    endif

endfunction
" }}}

" Status Line Format String
set statusline=
set statusline+=%{ChangeStatuslineColor()}
set statusline+=%#StatusLineMode#                               " Set colour
set statusline+=\ %{g:currentmode[mode()]}                      " Get Mode
set statusline+=\ %*                                            " Revert to default colour
set statusline+=%{get(b:,'filename','')}                        " Filename
set statusline+=%{get(b:,'git_branch','')}                      " Git branch
set statusline+=%{get(b:,'readonly_flag','')}\ %m%w             " Show readonly flag, and modified status

set statusline+=\ %*                                            " Revert to default colour
set statusline+=\ %=                                            " Right Side
set statusline+=\ %3(%{get(b:,'buf_size','')}%)                 " File size
set statusline+=\ %#StatusLineExtra#                            " Set colour
set statusline+=\ %<[%{&spelllang}]                             " Spell Language
set statusline+=%{(&filetype!=''?'\ ['.&filetype.']':'')}       " FileType
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}[%{&ff}]             " Encoding, File Format
set statusline+=\ %#StatusLineMode#                             " Set colour
set statusline+=\ %3p%%                                         " Percentage
set statusline+=\ %3l/%-3L:%-3c\                                " Line/Column Numbers

" }}}

" Maps I guess
nmap <C-q> :CtrlPBuffer<CR>

" Runtime path bs
set runtimepath^=~/.vim/bundle/ctrlp.vim
set clipboard=unnamed

" vim-notes settings
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'

" Relative line numbers
:set rnu

" Set escape
imap kj <Esc>

" No visual bell
set visualbell
