function! easyops#lang#javascript#GetMenuOptions() abort
  let l:tasks = []

  if !empty(findfile('package.json', '.;'))
    call extend(l:tasks, easyops#project#npm#GetOptions())
  endif

  if empty(l:tasks)
    let l:file = expand('%:p')
    call add(l:tasks, ['Node: Run Current File', 'node ' . shellescape(l:file)])
  endif

  return l:tasks
endfunction
