" wiki.vim: Vim syntax file
" Language: pukiwiki file
" Maintainer: Makoto MOMOTA <makoto.momota@gmail.com>
"
" copy this file to ~/.vim/syntax/ directory (create dirs if they are not
" present) and add the following to your ~/.vimrc file:
"
" augroup filetype
"  au! BufRead,BufNewFile *.wiki set filetype=wiki
" augroup END
" 
syntax clear

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

set enc=cp932
set fenc=utf-8
set textwidth=0

setlocal iskeyword+=/
setlocal iskeyword+=:
setlocal iskeyword+=.
setlocal iskeyword+=-

setlocal foldmethod=syntax
syn sync fromstart

" keyword
syntax keyword wikiKeyword ref contents hr clear comment pcomment article vote br size color
syntax keyword wikiKeyword ruby aname counter online version page fpage
syntax keyword wikiKeyword heart smile bigsmile huh oh wink sad worried
syntax keyword wikiKeyword LEFT: CENTER: RIGHT: BGCOLOR COLOR SIZE

" link
"   URL
syntax match wikiLink /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
"   e-mail
syntax match wikiLink /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
syntax region wikiLink  start="\[\[" end="\]\]"
syntax region wikiLink  start="\s\[#" end="\]$"
"   IP address
syntax match   wikiLink /\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}/

" comment
syntax region  wikiComment  start="^//" matchgroup=NONE end="$" contains=@cCommentGroup,wikiTodo
syntax region  wikiComment  start="%%" matchgroup=NONE end="%%" contains=@cCommentGroup,wikiTodo

" caption
syntax region  wikiTitle  start="^\**\s" end="$"

" list
syntax match  wikiList /^\-*\s/
syntax match  wikiList /^+*\s/
"syntax region  wikiList  start="\+*\s" end="$"
"syntax region  wikiList  start="\:" end="|"

" table
"syntax region  wikiTableHeader  start="^\|" end="\|h$"

" formed text
syntax region  wikiFormed  start="^\s" end="$"


" function (&.*, #.*, ...)
syntax region wikiFunction	start="^#" end="$"
syntax match wikiFunction	/&.*;/


" horizontal line
syntax region  wikiHorizon  start="^\-\-\-\-" end="$"

if version >= 508
    if version < 508
        let did_wiki_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    " special highlighting for deny keyword
    hi Deny gui=bold guifg=LightRed ctermfg=White ctermbg=LightRed term=underline

	HiLink wikiLink			Underlined
	HiLink wikiKeyword		Identifier
	HiLink wikiTitle		Statement
	HiLink wikiList			Deny
	HiLink wikiTableHeader	Underlined
    HiLink wikiComment		Comment
	HiLink wikiFormed		Constant
	HiLink wikiHorizon		Deny
	HiLink wikiFunction		PreProc


    delcommand HiLink
endif

let b:current_syntax = "wiki"

" vim:ts=4
