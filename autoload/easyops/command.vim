function! easyops#command#GetOptions(val) abort
	return get(g:, 'easyops_commands_'.val,{})
endfunction

function! easyops#command#GetProjectTypeOptions(type) abort
	let l:tasks    = []
	let l:config   = easyops#command#GetConfig('project', a:type)
	let l:cmd_list = l:config.commands
	let l:cli_cmd  = easyops#command#ProjectCommand(l:config)
	
	for [l:label,l:cmd] in items(l:commands)
		call add(l:tasks,[l:label, cli_cmd . l:cmd])
	endfor
	
	return l:tasks
endfunction

function! easyops#command#GetCommands(val) abort
	let l:loader = 'easyops#command#' . tolower(a:val) . '#commands'
  try
    let Fn = function(l:loader)
    return call(Fn, [])
  catch /.*/ 
    return {}
  endtry
endfunction

function! easyops#command#ProjectCommand(config) abort
	let l:manifest    = findfile(a:config['manifest'],'.;')
	let l:cli         = a:config.cli
	let l:root        = fnamemodify(l:manifest,':p:h')
	let l:cd          = 'cd ' . shellescape(l:root) . ' && '
	let l:confFile    = easyops#config#LoadConfig(l:root)
	let l:projectConf = get(l:confFile,a:type,{}) 
	let l:flags       = get(l:projectConf,a:type.'_opts','')

	return l:cd . l:cli. ' ' . l:flags . ' '
endfunction
