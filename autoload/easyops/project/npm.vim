let g:easyops_npm_commands = {
      \ 'npm: Install': 'install',
      \ 'npm: Build':   'run build',
      \ 'npm: Test':    'test',
      \ 'npm: Start':   'start'
      \ }

function! easyops#project#npm#GetMenuOptions() abort
	return easyops#menu#GetProjectOptions('package.json','npm','npm',g:easyops_npm_commands)
endfunction
