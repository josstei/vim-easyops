let g:easyops_cargo_commands = {
      \ 'Cargo: Build': 'clean',
      \ 'Cargo: Test' : 'compile',
      \ 'Cargo: Run': 'test',
      \ 'Cargo: Check': 'package',
      \ 'Cargo: Clean': 'install'
      \ }

let g:easyops_cargo_config = {
			\ 'manifest':'Cargo.toml',
			\ 'cli':'cargo',
			\ 'defaultConf': {'cargo_opts':''}
			\ }

let s:manifest = 'Cargo.toml'
let s:type     = 'cargo'
let s:cli      = 'cargo'
let s:initConf = {'cargo_opts':''}

function! easyops#project#cargo#GetMenuOptions() abort
	return easyops#menu#GetProjectOptions(s:manifest,s:type,s:cli,g:easyops_cargo_commands)
endfunction

function! easyops#project#cargo#InitConfig(root,cfg) abort
  call easyops#config#InitConfig(a:root, a:cfg, 'cargo', {'cargo_opts': '-DskipTests'})
endfunction
