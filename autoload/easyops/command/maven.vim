function! easyops#command#maven#commands() abort
  if !exists('g:easyops_commands_maven')
		let g:easyops_commands_maven = [
      \ { 'label': 'Maven: Clean',    'command': 'mvn clean' },
      \ { 'label': 'Maven: Compile',  'command': 'mvn compile' },
      \ { 'label': 'Maven: Test',     'command': 'mvn test' },
      \ { 'label': 'Maven: Package',  'command': 'mvn package' },
      \ { 'label': 'Maven: Install',  'command': 'mvn install' },
      \ { 'label': 'Maven: Verify',   'command': 'mvn verify' },
      \ { 'label': 'Maven: Deploy',   'command': 'mvn deploy' }
      \ ]
  endif

  if !exists('g:easyops_menu_maven')
    let g:easyops_menu_maven = {
          \ 'manifest' : 'pom.xml',
          \ 'default'  : {'maven_opts': ''},
          \ 'commands' : g:easyops_commands_maven
    			\ }
  endif
  return g:easyops_menu_maven
endfunction

function! EasyOps_Build(cmd) abort
  call EasyOps_LoadEnvVars()
  let l:opts = get(g:easyops_env, 'MAVEN_OPTS', '')
  execute '!MAVEN_OPTS=' . shellescape(l:opts) . ' mvn ' . a:cmd
endfunction

