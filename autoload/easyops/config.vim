function! easyops#config#InitConfig(root,type,config) abort
  let l:file    = easyops#config#GetConfig(root) abort
	let l:default = a:config.default

	if !has_key(a:cfg, a:project_type)
    let a:cfg[a:type] = a:defaults
    let l:configState = 'config initialized in ' . l:file

    call writefile([json_encode(a:cfg)], l:file)
  else
    let l:configState = 'config already exists'
  endif

  echom 'EasyOps: ' . a:project_type . ' ' .l:configState
endfunction

function! easyops#config#LoadConfig(root) abort
  let l:cfg  = {}
  let l:file = easyops#config#GetConfig(a:root) 

  if filereadable(l:file)
    try
      let l:cfg = json_decode(join(readfile(l:file), "\n"))
    catch
    endtry
  endif

  return l:cfg
endfunction

function! easyops#config#GetConfig(root) abort
  return a:root . '/.easyops.json'
endfunction
