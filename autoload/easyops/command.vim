function! easyops#command#GetCommandRoot(config) abort
	let l:manifest = findfile(get(a:config,'manifest'),'.;')
	return 'cd ' . shellescape(fnamemodify(l:manifest,':p:h')) . ' && '
endfunction

function! easyops#command#BuildTerminalCommand(command,config) abort
	let l:root          = easyops#command#GetCommandRoot(a:config)
    let l:env           = easyops#command#GetEnv()
	let l:full_command  = l:root . l:env . ' ' . a:command . ' ; echo "" ; echo "Press ENTER to close…" ; read'
	return printf('%s %s "%s"', &shell, &shellcmdflag, substitute(l:full_command, '"', '\\"', 'g'))
endfunction

function! easyops#command#executecommand(selection,config) abort
    let l:command   = a:selection.command
    let l:label     = a:selection.label

	if l:command[0] ==# ':'
		execute l:command
	else
		let l:command = easyops#command#BuildTerminalCommand(l:command,a:config)
        call easyops#command#ExecuteTerminalCommand(l:command,l:label)
	endif
endfunction

function! easyops#command#GetEnv() abort
    call easyops#config#LoadEasyOpsConfig()
    let l:env_parts = []

    if exists('g:easyops_env')
        for [key, val] in items(g:easyops_env)
            call add(l:env_parts, key . '=' . shellescape(val))
        endfor
    endif
    return join(l:env_parts, ' ')
endfunction

function! easyops#command#ExecuteTerminalCommand(command,label) abort
    execute 'botright terminal ++close ' . a:command
    execute 'file ' . string(a:label)
    if exists('+term_finish_cmd') | setlocal term_finish_cmd=close | endif
endfunction

