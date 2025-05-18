function! easyops#menu#file#GetMenuOptions() abort
	let l:tasks = []

	call add(l:tasks, ['File: Save',        ':w'])
	call add(l:tasks, ['File: Quit',        ':q'])
	call add(l:tasks, ['File: Quit(Force)', ':q!'])
	call add(l:tasks, ['File: Quit VIM',    ':qa!'])

	return l:tasks
endfunction

