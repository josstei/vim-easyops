function! easyops#project#maven#config() abort
  if !exists('g:easyops_commands_maven')
		let g:easyops_commands_maven = {
					\		'Maven: Clean':    'clean',
					\		'Maven: Compile':  'compile',
					\		'Maven: Test':     'test',
					\		'Maven: Package':  'package',
					\		'Maven: Install':  'install',
					\		'Maven: Verify':   'verify',
					\		'Maven: Deploy':   'deploy'
					\	}
  endif

  if !exists('g:easyops_config_maven')
    let g:easyops_config_maven= {
          \ 'manifest' : 'pom.xml',
          \ 'cli'      : 'mvn',
          \ 'default'  : {'maven_opts': ''},
          \ 'commands' : g:easyops_commands_maven
    			\ }
  endif
  return g:easyops_config_maven
endfunction

