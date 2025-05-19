let g:easyops_bundler_commands = {
      \ 'Bundler: Install':     'install',
      \ 'Bundler: Update':      'update',
      \ 'Bundler: Add Gem':     'add ',
      \ 'Bundler: Exec':        'exec ',
      \ 'Bundler: List':        'list',
      \ 'Bundler: Info':        'info ',
      \ 'Bundler: Outdated':    'outdated',
      \ 'Bundler: Check':       'check',
      \ 'Bundler: Init':        'init',
      \ 'Bundler: Lock':        'lock'
      \ }

function! easyops#project#bundler#GetMenuOptions() abort
	return easyops#menu#GetProjectOptions('Gemfile','bundler','bundle',g:easyops_bundler_commands)
endfunction

function! easyops#project#bundler#InitConfig(root,cfg) abort
  call easyops#config#InitConfig(a:root, a:cfg, 'bundler', {'bundler_opts': '-DskipTests'})
endfunction
