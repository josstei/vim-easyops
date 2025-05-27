function! easyops#command#file#commands() abort
  if !exists('g:easyops_commands_file')
		let g:easyops_commands_file= [
      \ { 'label': 'File: Save','command': ':w' },
      \ { 'label': 'File: Quit','command': ':q' },
      \ { 'label': 'File: Force Quit','command': ':q!' }
      \ ]
  endif
  if !exists('g:easyops_menu_file')
   let g:easyops_menu_file= { 'commands' : g:easyops_commands_file}
	endif
	return g:easyops_menu_file
endfunction
