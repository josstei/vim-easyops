function! easyops#command#vim#commands() abort
  if !exists('g:easyops_commands_vim')
    let l:file = expand('%:p')
    let g:easyops_commands_vim = [
          \ { 'label': 'Vim: Source Current File', 'command': ':source %' },
          \ { 'label': 'Vim: Reload Vim Config',   'command': ':source ' . expand('#MYVIMRC') },
          \ { 'label': 'Vim: Validate Syntax',     'command': 'vim -u NONE -c "syntax on" -c "runtime! plugin/**/*.vim" -c ' . shellescape(l:file) },
          \ { 'label': 'Vim: Open Documentation',  'command': ':help ' . expand('%:t') }
          \ ]
  endif
  if !exists('g:easyops_menu_vim')
    let g:easyops_menu_vim = { 'commands': g:easyops_commands_vim }
  endif
  return g:easyops_menu_vim
endfunction

