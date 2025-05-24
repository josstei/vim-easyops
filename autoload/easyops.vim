if exists('g:loaded_easyops_core')
  finish
endif

let g:loaded_easyops_core = 1

function! easyops#Execute(config) abort

  let l:command = a:config.command
  let l:label = a:config.command
	
  if empty(l:command) || l:command == '0'  | return | endif

	if l:command[0] ==# ':'
		execute l:command
		return
  endif

	let l:command .= ' ; echo "" ; echo "Press ENTER to close…" ; read'
  let l:shell    = &shell
  let l:flag     = &shellcmdflag
  let l:cmd_esc  = substitute(l:command, '"', '\\"', 'g')
  let l:full_cmd = printf('%s %s "%s"', l:shell, l:flag, l:cmd_esc)

	execute 'belowright terminal ++close ' . l:full_cmd
  execute 'file ' . string(l:label)

  if exists('+term_finish_cmd')
    setlocal term_finish_cmd=close
  endif
endfunction

