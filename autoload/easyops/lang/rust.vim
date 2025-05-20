function! easyops#lang#rust#config() abort
  if !exists('g:easyops_commands_rust')
		let l:file = expand('%:p')
		let g:easyops_commands_rust = {
					\ 'Rust: Compile': 'rustc ' . shellescape(l:file),
					\ 'Rust: Run':     'rustc ' . shellescape(l:file) . ' && ./' . expand('%:t:r')
					\	}
  endif

  if !exists('g:easyops_config_rust')
    let g:easyops_config_rust = { 'commands' : g:easyops_commands_rust }
  endif

  return g:easyops_config_rust
endfunction
