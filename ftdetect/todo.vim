" Description: todo.txt filetype detection
" Author:      Chris Morgan <me@chrismorgan.info>
" Licence:     Vim licence
" Website:     http://github.com/chris-morgan/todo.txt-vim
" Version:     1

autocmd BufNewFile,BufRead todo.txt set filetype=todo
autocmd BufNewFile,BufRead Todo.txt set filetype=todo
autocmd BufNewFile,BufRead TODO.txt set filetype=todo
