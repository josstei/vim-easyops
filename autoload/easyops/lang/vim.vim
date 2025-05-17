function! easyops#lang#vim#GetMenuOptions() abort
    let l:tasks = []
    let l:file = expand('%:p')

    call add(l:tasks, ['Source Current File', ':source %'])
    call add(l:tasks, ['Reload Vim Config',   ':source ' . expand('$MYVIMRC')])
    call add(l:tasks, ['Validate Syntax',     'vim -u NONE -c "syntax on" -c "runtime! plugin/**/*.vim" -c' . shellescape(l:file)])
    call add(l:tasks, ['Open Documentation',  ':help ' . expand('%:t')])

    return l:tasks
endfunction
