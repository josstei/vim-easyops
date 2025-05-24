function! easyops#command#javascript#commands() abort
  if !exists('g:easyops_commands_javascript')
		let g:easyops_commands_javascript = [
					\	{	'label': 'Node: Compile', 'command': 'node ' . shellescape(l:file) }
					\	]
  endif
  if !exists('g:easyops_menu_javascript')
		let g:easyops_menu_javascript = { 'commands' : g:easyops_commands_javascript }
	endif
	return g:easyops_menu_javascript
endfunction
