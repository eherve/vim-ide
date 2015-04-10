execute pathogen#infect()

set nocp " desactivate compatibility mode
set mouse=a " activate the mouse for all the time

" Appearance
colorscheme desert
set background=dark

" Set the encoding
set encoding=utf8

set ffs=unix,dos,mac " set UNIX as the standard file type

" Syntax options
syn on
set syntax=on " activate syntax coloration

set number " show line number on the left margin
set ruler " show info on the line on the bottom right

" Enable filetype plugin
filetype plugin on

" Indent options
filetype indent on
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Auto read file when changed
set autoread

set showmatch "activate coloration on open/close parenthesis

" Search options
"set ignorecase " search ignore case
"set smartcase " uppercase letter in search is case sensitif
set hlsearch " highlight the search match
set incsearch " select search result when taping

" Completion options
set wildmenu " show completion menu
set wildmode=list:longest,list:full " show all possibilities
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.swp,*.jar " completion filter
set omnifunc=syntaxcomplete#Complete

" Tabulation size
set expandtab " use space for tab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" TODO move to ftplugin
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.js,*.json :call DeleteTrailingWS()
autocmd BufWrite *.hpp,*.cpp :call DeleteTrailingWS()
autocmd BufWrite *.c,*.h :call DeleteTrailingWS()
autocmd BufWrite *.css :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.java :call DeleteTrailingWS()

" ctags
let ctags='/usr/bin/ctags'
let Tlist_Ctags_Cmd=ctags
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
let Tlist_Use_Right_Window=1

set tags=.tags
nmap <c-t> :!ctags -R -f .tags<CR>

" easy tag
let g:easytags_cmd=ctags
let g:easytags_async=1
let g:easytags_dynamic_files=2
let g:easytags_events=['BufWritePost']
nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>

" tagbar
nmap <F8> :TagbarToggle<CR>

" tree
nmap <F7> :NERDTreeToggle<CR>

" vim bufsurf
nmap <a-Left> :BufSurfBack<CR>
nmap <a-Right> :BufSurfForward<CR>

" ConqueTerm
let g:ConqueTerm_Color = 2 " term colors
let g:ConqueTerm_ReadUnfocused = 1 " still reading buffer when not focused
let g:ConqueTerm_InsertOnEnter = 0 " insert mode on entering buffer

" verbose
function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction
