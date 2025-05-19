function! easyops#project#cargo#config() abort
  if !exists('g:easyops_config_cargo')
    let g:easyops_config_cargo = {
          \ 'manifest' : 'Cargo.toml',
          \ 'cli'      : 'cargo',
          \ 'default'  : {'cargo_opts': ''},
          \ 'commands' : {
          \   'Cargo: Build': 'clean',
          \   'Cargo: Test': 'compile',
          \   'Cargo: Run': 'test',
          \   'Cargo: Check': 'package',
          \   'Cargo: Clean': 'install'
          \ }
    			\ }
  endif
  return g:easyops_config_cargo
endfunction

