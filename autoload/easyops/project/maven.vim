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

  call add(l:tasks, ['Maven: Clean',    l:cd . 'mvn ' . l:mvn_opts . ' clean'])
  call add(l:tasks, ['Maven: Compile',  l:cd . 'mvn ' . l:mvn_opts . ' compile'])
  call add(l:tasks, ['Maven: Test',     l:cd . 'mvn ' . l:mvn_opts . ' test'])
  call add(l:tasks, ['Maven: Package',  l:cd . 'mvn ' . l:mvn_opts . ' package'])
  call add(l:tasks, ['Maven: Install',  l:cd . 'mvn ' . l:mvn_opts . ' install'])
  call add(l:tasks, ['Maven: Verify',   l:cd . 'mvn ' . l:mvn_opts . ' verify'])
  call add(l:tasks, ['Maven: Deploy',   l:cd . 'mvn ' . l:mvn_opts . ' deploy'])

  return l:tasks
endfunction

function! easyops#project#maven#InitConfig(root,cfg) abort
  call easyops#project#InitConfig(a:root, a:cfg, 'maven', {'maven_opts': '-DskipTests'})
endfunction

