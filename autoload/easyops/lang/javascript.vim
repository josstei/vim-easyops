function! easyops#lang#javascript#GetMenuOptions() abort
	let l:tasks = []
	let l:pkg = findfile('package.json', '.;')
	call add(l:tasks, ['Lint with ESLint', 'npm run lint'])
	call add(l:tasks, ['Run Tests', 'npm test'])
	call add(l:tasks, ['Start Dev Server', 'npm start'])
	call add(l:tasks, ['Build for Production', 'npm run build'])
	return l:tasks
endfunction

