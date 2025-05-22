function! easyops#lang#vim#config() abort
  if !exists('g:easyops_commands_vim')
		let l:file = expand('%:p')
		let g:easyops_commands_vim = {
					\ 'Vim: Source Current File': ':source %',
					\ 'Vim: Reload Vim Config':   ':source ' . expand('#MYVIMRC'),
					\ 'Vim: Validate Syntax':     'vim -u NONE -c "syntax on" -c "runtime! plugin/**/*.vim" -c' . shellescape(l:file),
					\ 'Vim: Open Documentation':  ':help ' . expand('%:t') 
					\	}
  endif

  if !exists('g:easyops_config_vim')
    let g:easyops_config_vim= { 'commands' : g:easyops_commands_vim}
  endif

  return g:easyops_config_vim
endfunction
