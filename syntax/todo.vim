" Description: todo.txt syntax highlighter
" Author:      Chris Morgan <me@chrismorgan.info>
" Licence:     Vim licence
" Website:     http://github.com/chris-morgan/todo.txt-vim
" Version:     1

if exists("b:current_syntax")
    finish
endif

" These come first to be the lowest priority matches
syn match todoUnprioritisedLine "^.*$" contains=todoUnprioritisedLineSOL
syn match todoUnprioritisedLineSOL "^" nextgroup=todoStartDate,todoText
syn match todoText ".*$" transparent contained contains=todoProject,todoContext,todoKVPair,todoHyperlink

syn match todoDoneLine "^x .*$" contains=todoDone
for letter in split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '\zs')
	exec 'syn match todoPriority' . letter . 'Line "^(' . letter . ') .*$" contains=todoPriority' . letter
	exec 'syn match todoPriority' . letter . ' "^(' . letter . ') " contained nextgroup=todoStartDate,todoText'
endfor
syn match todoDone "^x " contained nextgroup=todoEndDate,todoText contains=@NoSpell
syn match todoEndDate "\d\{4}-\d\{2}-\d\{2}\%( \|$\)"he=s+10 contained nextgroup=todoStartDate,todoText
syn match todoStartDate "\d\{4}-\d\{2}-\d\{2}\%( \|$\)"he=s+10 contained nextgroup=todoText
" Project and context must have whitespace/EOL before and after; they may have
" any non-whitespace character inside them but must end in alphanumeric or _.
syn match todoProject "\%(^\| \)\@<=+\S*[A-Za-z0-9_]\ze\%( \|$\)" contained contains=@NoSpell
syn match todoContext "\%(^\| \)\@<=@\S*[A-Za-z0-9_]\ze\%( \|$\)" contained contains=@NoSpell
" May as well be nice and give formatting for dates in the rest of it.
" Since there's the suggestion of key:value pairs, allow colon before as well
syn match todoDate "\%(^\| \|:\)\@<=\d\{4}-\d\{2}-\d\{2}\ze\%( \|$\)" contained

" Key-value pairs. The recommended means of extensibility.
" e.g. due:2001-01-01
syn match todoKVPair "\%(^\| \)\@<=\S\+:\S\+\ze\%( \|$\)" transparent contained contains=todoKVPairKey
syn match todoKVPairKey "\S\+\ze:" contained nextgroup=todoKVPairColon
syn match todoKVPairColon ":" contained nextgroup=todoKVPairValue
syn match todoKVPairValue "\S\+" contained contains=todoDate

" Hyperlinks; not official in the spec, but nice to have.
syn match todoHyperlink "[a-z-]\+://\S\+" contained

hi def link todoHyperlink Underlined
hi def link todoKVPairKey Macro
hi def link todoKVPairColon Type
hi def link todoKVPairValue String
hi def link todoDoneLine		Comment
hi def link todoDone			Comment

let g:todo_cterm_256_priorities = 1
if exists("g:todo_cterm_256_priorities") && g:todo_cterm_256_priorities != 0 && exists("&t_Co") && &t_Co == 256
	hi def todoPriorityALine ctermfg=196
	hi def todoPriorityBLine ctermfg=202
	hi def todoPriorityCLine ctermfg=208
	hi def todoPriorityDLine ctermfg=214
	hi def todoPriorityELine ctermfg=220
	hi def todoPriorityFLine ctermfg=190
	hi def todoPriorityGLine ctermfg=154
	hi def todoPriorityHLine ctermfg=118
	hi def todoPriorityILine ctermfg=82
	hi def todoPriorityJLine ctermfg=46
	hi def todoPriorityKLine ctermfg=46
	hi def todoPriorityLLine ctermfg=47
	hi def todoPriorityMLine ctermfg=48
	hi def todoPriorityNLine ctermfg=49
	hi def todoPriorityOLine ctermfg=50
	hi def todoPriorityPLine ctermfg=51
	hi def todoPriorityQLine ctermfg=45
	hi def todoPriorityRLine ctermfg=39
	hi def todoPrioritySLine ctermfg=33
	hi def todoPriorityTLine ctermfg=27
	hi def todoPriorityULine ctermfg=21
	hi def todoPriorityVLine ctermfg=57
	hi def todoPriorityWLine ctermfg=93
	hi def todoPriorityXLine ctermfg=129
	hi def todoPriorityYLine ctermfg=165
	hi def todoPriorityZLine ctermfg=201
endif

if !exists("g:todo_priority_abc_special") || g:todo_priority_abc_special == 1
	hi def link todoPriorityALine	Constant
	hi def link todoPriorityBLine	Statement
	hi def link todoPriorityCLine	Identifier
	for letter in split("DEFGHIJKLMNOPQRSTUVWXYZ", '\zs')
		exec "hi def link todoPriority" . letter . "Line todoPriorityLine"
	endfor
else
	for letter in split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", '\zs')
		exec "hi def link todoPriority" . letter . "Line todoPriorityLine"
	endfor
endif
hi def link todoPriorityLine	NONE
for letter in split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", '\zs')
	exec "hi def link todoPriority" . letter . " todoPriority"
endfor
hi def link todoPriority		Statement
hi def link todoDate			PreProc
hi def link todoStartDate		todoDate
hi def link todoEndDate			todoDate
hi def link todoProject			Special
hi def link todoContext			StorageClass

let b:current_syntax = "todo"
