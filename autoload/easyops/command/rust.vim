function! easyops#command#rust#commands() abort
  if !exists('g:easyops_commands_rust')
		let l:file = expand('%:p')
		let g:easyops_commands_rust = [
					\	{	'label': 'Rust: Compile', 'command': 'rustc ' .shellescape(l:file) },
					\	{	'label': 'Rust: Run', 'command': 'rustc ' . shellescape(l:file) . ' && ./' . expand('%:t:r') }
					\	]
  endif
  if !exists('g:easyops_menu_rust')
   let g:easyops_menu_rust = { 'commands' : g:easyops_commands_rust }
	endif

	return g:easyops_menu_rust
endfunction
