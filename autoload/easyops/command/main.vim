function! easyops#command#main#commands() abort
  if !exists('g:easyops_commands_main')
		let g:easyops_commands_main = [
				\ { 'label' : 'Git' }, 
				\ { 'label' : 'File' }, 
				\ { 'label' : 'Window' }, 
				\ { 'label' : 'Code' } 
				\	]
		endif
  if !exists('g:easyops_menu_main')
   let g:easyops_menu_main = { 'commands' : g:easyops_commands_main}
	endif
	return g:easyops_menu_main
endfunction
