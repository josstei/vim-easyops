function! easyops#lang#javascript#config() abort
  if !exists('g:easyops_commands_javascript')
		let l:file = expand('%:p')
		let g:easyops_commands_javascript = {
					\		'Node: Compile': 'node ' . shellescape(l:file)
					\	}
  endif

  if !exists('g:easyops_config_javascript')
    let g:easyops_config_javascript = { 'commands' : g:easyops_commands_java }
  endif

  return g:easyops_config_javascript
endfunction
