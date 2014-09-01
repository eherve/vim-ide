set expandtab " use space for tab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Folding
set foldmethod=syntax
set foldnestmax=2
set foldlevelstart=1
set foldlevel=99

" Completion
setlocal omnifunc=javacomplete#Complete
setlocal completefunc=javacomplete#CompleteParamsInfo 
