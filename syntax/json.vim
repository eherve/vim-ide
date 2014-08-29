" Vim syntax file
" Language:	JSON


" Def braces
syn match   jsonBraces	   "[{}\[\]]"

" Def string
syn region  jsonString    start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=jsonEsca
syn match   jsonEscape    "\\["\\/bfnrt]" contained
syn match   jsonEscape    "\\u\x\{4}" contained
"
" Def key
syn match jsonKey /"[^"]\+"[ \t\n]*:/me=e-1

" Def single quote error
syn region  jsonStringSQ  start=+'+  skip=+\\\\\|\\"+  end=+'+

" Def no quote error
syn match   jsonNoQuotes  "\<\a\+\>"

" Def number
syn match   jsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
syn match   jsonNumError  "-\=\<0\d\.\d*\>"

" Def boolean
syn keyword jsonBoolean true false

" Def null
syn keyword jsonNull null

" Highlight
hi link jsonString String
hi link jsonKey Comment
hi link jsonBoolean Boolean
hi link jsonNull Function
hi link jsonNumber Number

" Highlight Error
hi link jsonStringSQ Error
hi link jsonNoQuotes Error
hi link jsonNumError Error
