function! easyops#project#cargo#GetOptions() abort
  let l:tasks      = []
  let l:cargo_file = findfile('Cargo.toml', '.;')

  if empty(l:cargo_file)
    return l:tasks
  endif

  let l:root       = fnamemodify(l:cargo_file, ':p:h')
  let l:cd         = 'cd ' . shellescape(l:root) . ' && '
  let l:config     = easyops#LoadConfig(l:root)
  let l:cargo_opts = get(l:config, 'cargo_opts', '')

  call add(l:tasks, ['Cargo: Build', l:cd . 'cargo '   . l:cargo_opts . ' build'])
  call add(l:tasks, ['Cargo: Test',  l:cd . 'cargo '   . l:cargo_opts . ' test'])
  call add(l:tasks, ['Cargo: Run',   l:cd . 'cargo '   . l:cargo_opts . ' run'])
  call add(l:tasks, ['Cargo: Check', l:cd . 'cargo '   . l:cargo_opts . ' check'])
  call add(l:tasks, ['Cargo: Clean', l:cd . 'cargo '   . l:cargo_opts . ' clean'])

  return l:tasks
endfunction
