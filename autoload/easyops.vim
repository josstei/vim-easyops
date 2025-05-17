if exists('g:loaded_easyops_core')
  finish
endif

let g:loaded_easyops_core = 1

function! easyops#LoadConfig(root) abort
  let l:cfg = {}
  let l:file = a:root . '/.easyops.json'

  if filereadable(l:file)
    try
      let l:cfg = json_decode(join(readfile(l:file), "\n"))
    catch
    endtry
  endif

  return l:cfg
endfunction

function! easyops#Execute(winid,idx) abort
  if a:idx <= 0 | return | endif

  let l:base = get(g:easyops_cmds, a:idx - 1, [])
  let l:cmd  = l:base

  if empty(l:cmd) | return | endif

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
  execute 'file ' . string(l:base)

  if exists('+term_finish_cmd')
    setlocal term_finish_cmd=close
  endif
endfunction

