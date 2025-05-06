function! s:executeCommand(id, result) abort
	if a:result < 1
		return
	endif
	let l:index = a:result - 1
	let l:cmd   = g:easyops_last_cmds[l:index]
	let l:shell = &shell
	let l:flag  = &shellcmdflag
	let l:cmd_esc = substitute(l:cmd, '"', '\\"', 'g')
	let l:full = printf('%s %s "%s"', l:shell, l:flag, l:cmd_esc)

	execute 'belowright terminal ' . l:full
endfunction

" gotta make this a map
function! easyops#OpenMenu() abort
	let l:ft = &filetype
	if l:ft ==# 'javascriptreact'
		let l:ctx = 'react'
	elseif l:ft ==# 'java'
		let l:ctx = 'java'
	elseif l:ft ==# 'javascript'
		let l:ctx = 'javascript'
	elseif l:ft ==# 'cpp' || l:ft ==# 'c++' || l:ft ==# 'c'
		let l:ctx = 'cpp'
	else
		echo "EasyOps: No menu available for filetype '" . l:ft . "'"
		return
	endif

	let l:tasks = call('easyops#lang#' . l:ctx . '#GetMenuOptions', [])
	if empty(l:tasks)
		echo "EasyOps: No actions defined for " . l:ctx
		return
	endif

	let g:easyops_last_cmds = map(copy(l:tasks), 'v:val[1]')
	let l:menu_items = map(copy(l:tasks), 'v:val[0]')

	if exists('*popup_menu')
		call popup_menu(l:menu_items, #{
			\ title: 'EasyOps: ' . l:ctx,
			\ callback: 's:executeCommand'
			\ })
  else
		let l:choices = ['Select action:']
		for i in range(1, len(l:menu_items))
			call add(l:choices, printf("%d. %s", i, l:menu_items[i-1]))
		endfor
		let l:choice = inputlist(l:choices)
		if l:choice >= 1 && l:choice <= len(g:easyops_last_cmds)
			execute 'terminal ' . g:easyops_last_cmds[l:choice - 1]
		endif
	endif
endfunction

