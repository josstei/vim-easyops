function! EasyOpsChoiceCB(id, result) abort
  if a:result >= 1 && exists('g:easyops_last_cmds')
    let l:index = a:result - 1   " convert 1-based index to 0-based list index
    let l:cmd = g:easyops_last_cmds[l:index]
    execute 'terminal ' . l:cmd 
  endif
endfunction

function! easyops#OpenMenu() abort
  let l:ft = &filetype
  if l:ft ==# 'javascriptreact'
    let l:ctx = 'react'
  elseif l:ft ==# 'java'
    let l:ctx = 'java'
  elseif l:ft ==# 'javascript'
    let l:ctx = 'javascript'
  elseif l:ft ==# 'cpp' || l:ft ==# 'c++' || l:ft ==# 'c'
    let l:ctx = 'cpp'
  else
    echo "EasyOps: No menu available for filetype '" . l:ft . "'"
    return
  endif

  " Get the list of [label, command] tasks from the appropriate module
  let l:tasks = call('easyops#' . l:ctx . '#GetMenuOptions', [])
  if empty(l:tasks)
    echo "EasyOps: No actions defined for " . l:ctx
    return
  endif

  let g:easyops_last_cmds = map(copy(l:tasks), 'v:val[1]')   " store commands globally
  let l:menu_items = map(copy(l:tasks), 'v:val[0]')          " list of menu option text

  if exists('*popup_menu')  " if popup windows are supported in this Vim:contentReference[oaicite:3]{index=3}
    " Show popup menu near the cursor with a title, using our callback on selection
    call popup_menu(l:menu_items, #{
          \ title: 'EasyOps: ' . l:ctx,
          \ callback: 'EasyOpsChoiceCB'
          \ })
    " (Vim will call EasyOpsChoiceCB(id, result) when an item is chosen or menu closed)
  else
    let l:choices = ['Select action:']
    for i in range(1, len(l:menu_items))
      call add(l:choices, printf("%d. %s", i, l:menu_items[i-1]))
    endfor
    let l:choice = inputlist(l:choices)
    if l:choice >= 1 && l:choice <= len(g:easyops_last_cmds)
			echom 'test: ' . g:easyops_last_cmds[l:choice - 1] 

      execute 'terminal ' . g:easyops_last_cmds[l:choice - 1]
    endif
  endif
endfunction

