function! easyops#lang#rust#GetMenuOptions() abort
  let l:tasks      = []

  if !empty(findfile('Cargo.toml', '.;'))
    call extend(l:tasks, easyops#project#cargo#GetOptions())
  endif

  if empty(l:tasks)
    let l:file = expand('%:p')
    call add(l:tasks, ['Compile Current File',  'rustc ' . shellescape(l:file)])
    call add(l:tasks, ['Run Current Executable', 'rustc ' . shellescape(l:file) . ' && ./' . expand('%:t:r')])
  endif

  return l:tasks
endfunction
