let g:easyops_maven_commands = {
      \ 'Maven: Clean':    'clean',
      \ 'Maven: Compile':  'compile',
      \ 'Maven: Test':     'test',
      \ 'Maven: Package':  'package',
      \ 'Maven: Install':  'install',
      \ 'Maven: Verify':   'verify',
      \ 'Maven: Deploy':   'deploy'
      \ }

function! easyops#project#maven#GetMenuOptions() abort
	return easyops#menu#GetProjectOptions('pom.xml','maven','mvn',g:easyops_maven_commands)
endfunction

function! easyops#project#maven#InitConfig(root,cfg) abort
  call easyops#project#InitConfig(a:root, a:cfg, 'maven', {'maven_opts': '-DskipTests'})
endfunction

