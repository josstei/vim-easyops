function! easyops#command#GetRoot(config) abort
    let l:manifest = findfile(get(a:config,'manifest'),'.;')
    return 'cd ' . shellescape(fnamemodify(l:manifest,':p:h')) . ' && '
endfunction

function! easyops#command#BuildTerminalCommand(command,config) abort
    let l:root          = easyops#command#GetRoot(a:config)
    let l:env           = easyops#command#GetEnv()
    let l:full_command  = l:root . l:env . ' ' . a:command . ' ; echo "" ; echo "Press ENTER to close…" ; read'
    return l:full_command
endfunction

function! easyops#command#Execute(selection,config) abort
    let l:command   = a:selection.cmd
    let l:label     = a:selection.label

	if l:command[0] ==# ':'
		execute l:command
	else
		let l:command = easyops#command#BuildTerminalCommand(l:command,a:config)
        call easyops#command#ExecuteCommand(l:command,l:label)
	endif
endfunction

function! easyops#command#GetEnv() abort
    call easyops#config#LoadEasyOpsConfig()
    let l:env_parts = []

    if exists('g:easyops_env')
        for [key, val] in items(g:easyops_env)
            execute 'let $' . key .' = ' . shellescale(val,1)
        endfor
    endif
    return join(l:env_parts, ' ')
endfunction

function! easyops#command#ExecuteCommand(command, label) abort
    call easyops#buffer#Get()
    call easyops#terminal#Execute(a:command)
    call easyops#buffer#Rename(a:label)
"     call easyops#terminal#Close()
endfunction
