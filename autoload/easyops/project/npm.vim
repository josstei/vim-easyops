function! easyops#project#npm#config() abort
  if !exists('g:easyops_config_npm')
    let g:easyops_config_npm= {
          \ 'manifest' : 'package.json',
          \ 'cli'      : 'npm',
          \ 'default'  : {'npm_opts': ''},
          \ 'commands' : {
					\		'npm: Install': 'install',
					\		'npm: Build':   'run build',
					\		'npm: Test':    'test',
					\		'npm: Start':   'start'
					\		}    			
					\ }
  endif
  return g:easyops_config_npm
endfunction
