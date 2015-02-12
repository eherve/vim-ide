" Folding
set foldmethod=syntax
set foldnestmax=2
set foldlevelstart=1
set foldlevel=99

" Tags
set tags=.tags-java
nmap <c-t> :!find -name *.java -exec ctags --sort=yes -u -a -f .tags-java {} \;<CR>

" Completion
setlocal omnifunc=javacomplete#Complete
setlocal completefunc=javacomplete#CompleteParamsInfo 
