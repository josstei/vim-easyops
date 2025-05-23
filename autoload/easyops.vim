if exists('g:loaded_easyops_core')
  finish
endif

let g:loaded_easyops_core = 1

function! easyops#Execute(cmd) abort

  let l:cmd  = a:cmd
	
  if empty(l:cmd) || l:cmd == '0'  | return | endif

	if l:cmd[0] ==# ':'
		execute l:cmd
		return
  endif

	let l:cmd     .= ' ; echo "" ; echo "Press ENTER to close…" ; read'
  let l:shell    = &shell
  let l:flag     = &shellcmdflag
  let l:cmd_esc  = substitute(l:cmd, '"', '\\"', 'g')
  let l:full_cmd = printf('%s %s "%s"', l:shell, l:flag, l:cmd_esc)

	execute 'belowright terminal ++close ' . l:full_cmd
  execute 'file ' . string(l:cmd)

  if exists('+term_finish_cmd')
    setlocal term_finish_cmd=close
  endif
endfunction

