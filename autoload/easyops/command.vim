function! easyops#command#GetFileTypeOptions(filetype) abort
  let l:tasks    = []
	let l:config   = easyops#command#GetConfig('lang', a:filetype)
	let l:commands = l:config.commands

	for [l:label,l:cmd] in items(l:commands)
		call add(l:tasks,[l:label,l:cmd])
	endfor

	return l:tasks
endfunction

function! easyops#command#GetProjectTypeOptions(type) abort
	let l:tasks    = []
	let l:config   = easyops#command#GetConfig('project', a:type)
	let l:manifest = findfile(l:config['manifest'],'.;')

	if empty(l:manifest) | return l:tasks | endif

	let l:cli         = l:config.cli
	let l:commands    = l:config.commands
	let l:root        = fnamemodify(l:manifest,':p:h')
	let l:cd          = 'cd ' . shellescape(l:root) . ' && '
	let l:confFile    = easyops#config#LoadConfig(l:root)
	let l:projectConf = get(l:confFile,a:type,{}) 
	let l:flags       = get(l:projectConf,a:type.'_opts','')
	
  if empty(l:projectConf)
"     call add(l:tasks, ['Init EasyOps', printf(':call easyops#config#InitConfig(%s,%s,%s)', string(l:root), a:type, l:projectConf)])
" 		return l:tasks
  endif

	for [l:label,l:cmd] in items(l:commands)
		call add(l:tasks,[l:label, l:cd . l:cli. ' ' . l:flags . ' ' . l:cmd])
	endfor
	
	return l:tasks
endfunction

function! easyops#command#GetConfig(configType,configOption) abort
	let l:loader = 'easyops#' . a:configType . '#' . a:configOption . '#config'
  try
    let Fn = function(l:loader)
    return call(Fn, [])
  catch /.*/ 
    return {}
  endtry
endfunction
