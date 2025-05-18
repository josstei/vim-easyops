function! easyops#menu#git#GetMenuOptions() abort
	let l:tasks = []

	call add(l:tasks, ['Git: Status',       'git status'])
	call add(l:tasks, ['Git: Add All',      'git add --all'])
	call add(l:tasks, ['Git: Commit',       'git commit'])
	call add(l:tasks, ['Git: Pull',         'git pull'])
	call add(l:tasks, ['Git: Push',         'git push'])
	call add(l:tasks, ['Git: Log (Paged)',  'git --no-pager log --oneline --graph'])
	call add(l:tasks, ['Git: Fetch',     		'git fetch'])
	call add(l:tasks, ['Git: Branches',     'git branch -a'])
	call add(l:tasks, ['Git: Checkout...',  'git checkout '])

	return l:tasks
endfunction

