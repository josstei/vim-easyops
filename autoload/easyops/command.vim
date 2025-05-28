function! easyops#command#GetCommandRoot(config) abort
	let l:manifest = findfile(get(a:config,'manifest'),'.;')
	return 'cd ' . shellescape(fnamemodify(l:manifest,':p:h')) . ' && '
endfunction

function! easyops#command#GetCommandTerminal(selection,config) abort
	let l:root    = easyops#command#GetCommandRoot(a:config)
	let l:command = l:root . a:selection.command . ' ; echo "" ; echo "Press ENTER to close…" ; read'
	return printf('%s %s "%s"', &shell, &shellcmdflag, substitute(l:command, '"', '\\"', 'g'))
endfunction

function! easyops#command#ExecuteCommand(selection,config) abort
	if a:selection.command[0] ==# ':'
		execute a:selection.command
	else
		let l:command = easyops#command#GetCommandTerminal(a:selection,a:config)

		execute 'belowright terminal ++close ' . l:command
		execute 'file ' . string(a:selection.label)

		if exists('+term_finish_cmd') | setlocal term_finish_cmd=close | endif
	endif
endfunction

