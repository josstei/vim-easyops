function! easyops#command#easyopsconfig#commands() abort
  if !exists('g:easyops_commands_easyopsconfig')
		let g:easyops_commands_easyopsconfig= [
					\	{	'label': 'Config: Initialize Config', 'command': 'javac -d target/classes ' . expand('%') }
					\	]
  endif
  if !exists('g:easyops_menu_easyopsconfig')
   let g:easyops_menu_easyopsconfig = { 'commands' : g:easyops_commands_easyopsconfig}
	endif
	return g:easyops_menu_easyopsconfig
endfunction

function! easyops#config#InitConfig() abort
	let l:root = 'getroothere'
  let l:settings = easyops#config#GetConfig(root) abort
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
