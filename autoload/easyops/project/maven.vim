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
  let l:tasks = []
  let l:pom   = findfile('pom.xml', '.;')

  if empty(l:pom)
    return l:tasks
  endif

  let l:root       = fnamemodify(l:pom, ':p:h')
  let l:cd         = 'cd ' . shellescape(l:root) . ' && '
  let l:config     = easyops#project#LoadConfig(l:root)
  let l:maven_conf = get(l:config, 'maven', {})
  let l:mvn_opts   = get(l:maven_conf, 'maven_opts', '')

  if empty(l:maven_conf)
    call add(l:tasks, ['Maven: Init EasyOps', printf(':call easyops#project#maven#InitConfig(%s,%s)', string(l:root), l:config)])
		return l:tasks
  endif

	for [l:label, l:cmd] in items(g:easyops_maven_commands)
		call add(l:tasks, [l:label, l:cd . 'mvn ' . l:mvn_opts . ' ' . l:cmd])
	endfor

  return l:tasks
endfunction

function! easyops#project#maven#InitConfig(root,cfg) abort
  call easyops#project#InitConfig(a:root, a:cfg, 'maven', {'maven_opts': '-DskipTests'})
endfunction

