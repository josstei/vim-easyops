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

function! easyops#command#Execute(selection,config) abort
    let l:command   = a:selection.cmd
    let l:label     = a:selection.label

	if l:command[0] ==# ':'
		execute l:command
	else
		let l:command = easyops#command#BuildTerminalCommand(l:command,a:config)
        call easyops#command#ExecuteTerminal(l:command,l:label)
	endif
endfunction

function! easyops#command#GetEnv() abort
    call easyops#config#LoadEasyOpsConfig()
    let l:env_parts = []

    if exists('g:easyops_env')
        for [key, val] in items(g:easyops_env)
            call add(l:env_parts, key . '=' . shellescape(val,1))
        endfor
    endif
    return join(l:env_parts, ' ')
endfunction

function! easyops#command#ExecuteTerminal(command, label) abort
    if !exists('g:term_bufnr') || !bufexists(g:term_bufnr) || !buflisted(g:term_bufnr)
        if has('nvim')
            botright 15split
            terminal
        else
            botright terminal
            resize 15
        endif
        let g:term_bufnr = bufnr('%')
    else
        botright 15split
        execute 'buffer' g:term_bufnr
    endif

    call feedkeys("i" . a:command . "\r", "t")
    execute 'file ' . string(a:label)
endfunction
