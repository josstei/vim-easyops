function! easyops#config#InitConfig(root,type,config) abort
  let l:file    = a:root . '/.easyops.json'
	let l:default = a:config.default

	if !has_key(a:cfg, a:project_type)
    let a:cfg[a:type] = a:defaults

    call writefile([json_encode(a:cfg)], l:file)
    echom 'EasyOps: ' . a:project_type . ' config initialized in ' . l:file
  else
    echom 'EasyOps: ' . a:project_type . ' config already exists.'
  endif
endfunction

function! easyops#config#LoadConfig(root) abort
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

function! easyops#config#CreateConfigFile() abort
  let l:path = getcwd() . '/.easyops.json'

  if filereadable(l:path)
    echom 'EasyOps Config already exists at ' . l:path
    return
  endif

  let l:default_config = { "environment": {}}

  call writefile([json_encode(l:default_config)], l:path)
  echom 'EasyOps Config created at ' . l:path
endfunction
