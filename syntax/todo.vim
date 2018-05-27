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

hi def todoPriorityALine ctermfg=196 guifg=#ff0000
hi def todoPriorityBLine ctermfg=202 guifg=#ff5f00
hi def todoPriorityCLine ctermfg=208 guifg=#ff8700
hi def todoPriorityDLine ctermfg=214 guifg=#ffaf00
hi def todoPriorityELine ctermfg=220 guifg=#ffd700
hi def todoPriorityFLine ctermfg=190 guifg=#d7ff00
hi def todoPriorityGLine ctermfg=154 guifg=#afff00
hi def todoPriorityHLine ctermfg=118 guifg=#87ff00
hi def todoPriorityILine ctermfg=82 guifg=#54ff00
hi def todoPriorityJLine ctermfg=46 guifg=#00ff00
" Might have made a mistake here in H, I and J? Note that #ffff00 wasn’t used.
hi def todoPriorityKLine ctermfg=46 guifg=#00ff00
hi def todoPriorityLLine ctermfg=47 guifg=#00ff5f
hi def todoPriorityMLine ctermfg=48 guifg=#00ff87
hi def todoPriorityNLine ctermfg=49 guifg=#00ffaf
hi def todoPriorityOLine ctermfg=50 guifg=#00ffd7
hi def todoPriorityPLine ctermfg=51 guifg=#00ffff
hi def todoPriorityQLine ctermfg=45 guifg=#00d7ff
hi def todoPriorityRLine ctermfg=39 guifg=#00afff
hi def todoPrioritySLine ctermfg=33 guifg=#0087ff
hi def todoPriorityTLine ctermfg=27 guifg=#005fff
hi def todoPriorityULine ctermfg=21 guifg=#0000ff
hi def todoPriorityVLine ctermfg=57 guifg=#5f00ff
hi def todoPriorityWLine ctermfg=93 guifg=#8700ff
hi def todoPriorityXLine ctermfg=129 guifg=#af00ff
hi def todoPriorityYLine ctermfg=165 guifg=#d700ff
hi def todoPriorityZLine ctermfg=201 guifg=#ff00ff

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
