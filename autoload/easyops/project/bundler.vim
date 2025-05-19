function! easyops#project#bundler#config() abort
  if !exists('g:easyops_config_bundler')
    let g:easyops_config_bundler= {
          \ 'manifest' : 'Gemfile',
          \ 'cli'      : 'bundle',
          \ 'default'  : {'bundler_opts': ''},
          \ 'commands' : {
					\		'Bundler: Install':     'install',
					\		'Bundler: Update':      'update',
					\		'Bundler: Add Gem':     'add ',
					\		'Bundler: Exec':        'exec ',
					\		'Bundler: List':        'list',
					\		'Bundler: Info':        'info ',
					\		'Bundler: Outdated':    'outdated',
					\		'Bundler: Check':       'check',
					\		'Bundler: Init':        'init',
					\		'Bundler: Lock':        'lock'
					\ }
    			\ }
  endif
  return g:easyops_config_bundler
endfunction
