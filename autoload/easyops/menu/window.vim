function! easyops#menu#window#GetMenuOptions() abort
	let l:tasks = []

	call add(l:tasks, ['Window: Split Horizontal', ':rightbelow split new'])
	call add(l:tasks, ['Window: Split Vertical',   ':rightbelow vs new'])
	return l:tasks
endfunction

