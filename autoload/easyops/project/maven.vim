function! easyops#project#maven#GetMenuOptions() abort
  let l:tasks = []
  let l:pom = findfile('pom.xml', '.;')

  if empty(l:pom)
    return l:tasks
  endif

  let l:root     = fnamemodify(l:pom, ':p:h')
  let l:cd       = 'cd ' . shellescape(l:root) . ' && '
  let l:config   = easyops#LoadConfig(l:root)
  let l:mvn_opts = get(l:config, 'maven_opts', '')

  call add(l:tasks, ['Maven: Clean',   l:cd . 'mvn ' . l:mvn_opts . ' clean'])
  call add(l:tasks, ['Maven: Compile', l:cd . 'mvn ' . l:mvn_opts . ' compile'])
  call add(l:tasks, ['Maven: Test',    l:cd . 'mvn ' . l:mvn_opts . ' test'])
  call add(l:tasks, ['Maven: Package', l:cd . 'mvn ' . l:mvn_opts . ' package'])
  call add(l:tasks, ['Maven: Install', l:cd . 'mvn ' . l:mvn_opts . ' install'])
  call add(l:tasks, ['Maven: Verify',  l:cd . 'mvn ' . l:mvn_opts . ' verify'])
  call add(l:tasks, ['Maven: Deploy',  l:cd . 'mvn ' . l:mvn_opts . ' deploy'])

  return l:tasks
endfunction
