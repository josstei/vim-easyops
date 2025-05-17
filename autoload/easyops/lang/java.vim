function! easyops#lang#java#GetMenuOptions() abort
  let l:tasks = []

  let l:file = expand('%:p')
  call add(l:tasks, ['Java: Compile (javac)', 'javac ' . shellescape(l:file)])
  call add(l:tasks, ['Java: Run (java)',     'java ' . expand('%:t:r')])

  return l:tasks
endfunction
