function! easyops#command#GetFileTypeOptions(filetype) abort
  let l:tasks    = []
	let l:file     = expand('%:p')
	let l:config   = easyops#command#GetConfig('lang', a:filetype)
	let l:commands = l:config.commands

	for [l:label,l:cmd] in items(l:commands)
		call add(l:tasks,[l:label,l:cmd])
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
