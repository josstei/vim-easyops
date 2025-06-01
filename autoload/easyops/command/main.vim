function! easyops#command#main#commands() abort
  if !exists('g:easyops_commands_main')
		let g:easyops_commands_main = [
				\ { 'label' : 'Git',     'command':'menu:git'}, 
				\ { 'label' : 'Window',  'command':'menu:window'}, 
				\ { 'label' : 'File',    'command':'menu:file'}, 
				\ { 'label' : 'Code',    'command':'menu:code|manifest'}, 
				\ { 'label' : 'Config',    'command':'menu:easyopsconfig'}, 
				\	]
		endif
  if !exists('g:easyops_menu_main')
   let g:easyops_menu_main = { 'commands' : g:easyops_commands_main}
	endif
	return g:easyops_menu_main
endfunction
