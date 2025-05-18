function! easyops#lang#rust#GetMenuOptions() abort
	let l:tasks = []
	let l:file  = expand('%:p')

	call add(l:tasks, ['Compile Current File',  'rustc ' . shellescape(l:file)])
	call add(l:tasks, ['Run Current Executable', 'rustc ' . shellescape(l:file) . ' && ./' . expand('%:t:r')])

  return l:tasks
endfunction
