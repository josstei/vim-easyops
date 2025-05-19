let g:easyops_cargo_commands = {
      \ 'Cargo: Build':    'clean',
      \ 'Cargo: Test':  'compile',
      \ 'Cargo: Run':     'test',
      \ 'Cargo: Check':  'package',
      \ 'Cargo: Clean':  'install'
      \ }

function! easyops#project#cargo#GetMenuOptions() abort
	return easyops#menu#GetProjectOptions('Cargo.toml','cargo','cargo',g:easyops_cargo_commands)
endfunction

function! easyops#project#cargo#InitConfig(root,cfg) abort
  call easyops#project#InitConfig(a:root, a:cfg, 'cargo', {'cargo_opts': '-DskipTests'})
endfunction
