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

" function! easyops#ShowMenu() abort
"   let l:cfg = easyops#LoadConfig(getcwd())
"   let l:opts = easyops#menu#GetMenuOptions()
" 
"   if empty(l:opts)
"     echohl WarningMsg | echom "EasyOps: No tasks available." | echohl None
"     return
"   endif
" 
"   let s:easyops_popup_opts = copy(l:opts)
"   let l:labels = map(l:opts, {_, v -> v[0]})
" 
"   if exists('*popup_menu')
"     call popup_menu(l:labels, #{
"           \ title:       'EasyOps Tasks',
"           \ cursorline:  v:true,
"           \ mapping:     v:true,
"           \ return_focus:v:true,
"           \ callback:    'easyops#Execute',
"           \ })
"   else
"     let l:choice = inputlist(['EasyOps Tasks:'] + l:labels) - 1
" 
"     if l:choice >= 0 && l:choice < len(l:opts)
"       call easyops#Execute(0, l:choice + 1,l:opts)
"     endif
"   endif
" endfunction

function! easyops#Execute(winid,idx,opts) abort
  if a:idx <= 0 | return | endif

  let l:pair = get(a:opts, a:idx - 1, [])

  if len(l:pair) != 2 | return | endif

  let l:base = l:pair[1]
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
  execute 'file ' . string(l:cmd)

  if exists('+term_finish_cmd')
    setlocal term_finish_cmd=close
  endif
endfunction

