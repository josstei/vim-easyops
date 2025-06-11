function! easyops#command#GetRoot(config) abort
    let l:manifest = findfile(get(a:config,'manifest'),'.;')
    return 'cd ' . shellescape(fnamemodify(l:manifest,':p:h')) . ' && '
endfunction

function! easyops#command#BuildTerminalCommand(command,config) abort
    let l:root          = easyops#command#GetRoot(a:config)
    let l:full_command  = l:root .' ' . a:command
    return l:full_command
endfunction

function! easyops#command#Execute(selection,config) abort
    let l:command   = a:selection.cmd
    let l:label     = a:selection.label

	if l:command[0] ==# ':'
		execute l:command
	else
		let l:command = easyops#command#BuildTerminalCommand(l:command,a:config)
        call easyops#command#LoadEnv()
        call easyops#command#ExecuteCommand(l:command,l:label)
	endif
endfunction

function! easyops#command#LoadEnv() abort
    if exists('g:easyenv_loaded') && g:easyenv_loaded
        call easyenv#Execute('Load')
    endif
endfunction

function! easyops#command#ExecuteCommand(command, label) abort
    call easyops#buffer#Get()
    call easyops#terminal#Execute(a:command)
endfunction
