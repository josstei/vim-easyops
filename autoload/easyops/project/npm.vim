function! easyops#project#npm#GetOptions() abort
  let l:tasks = []
  let l:pkg   = findfile('package.json', '.;')

  if empty(l:pkg)
    return l:tasks
  endif

  let l:root     = fnamemodify(l:pkg, ':p:h')
  let l:cd       = 'cd ' . shellescape(l:root) . ' && '
  let l:config   = easyops#LoadConfig(l:root)
  let l:npm_opts = get(l:config, 'npm_opts', '')

  call add(l:tasks, ['npm: Install', l:cd . 'npm ' . l:npm_opts . ' install'])
  call add(l:tasks, ['npm: Build',   l:cd . 'npm ' . l:npm_opts . ' run build'])
  call add(l:tasks, ['npm: Test',    l:cd . 'npm ' . l:npm_opts . ' test'])
  call add(l:tasks, ['npm: Start',   l:cd . 'npm ' . l:npm_opts . ' start'])

  return l:tasks
endfunction
