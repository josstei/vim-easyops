function! easyops#project#cargo#config() abort
  if !exists('g:easyops_config_cargo')
    let g:easyops_config_cargo = {
          \ 'manifest' : 'Cargo.toml',
          \ 'cli'      : 'cargo',
          \ 'default'  : {'cargo_opts': ''},
          \ 'commands' : {
          \			'Cargo: Build': 'build',
          \			'Cargo: Test': 'test',
          \			'Cargo: Run': 'run',
          \			'Cargo: Check': 'check',
          \			'Cargo: Clean': 'clean'
          \		}
    			\ }
  endif
  return g:easyops_config_cargo
endfunction

