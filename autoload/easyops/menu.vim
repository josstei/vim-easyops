function! easyops#menu#ShowCategories() abort
	let l:categories= [
        \ 'Git ▶',
        \ 'Window ▶',
        \ 'File ▶',
        \ 'Code ▶',
        \ ]
	call popup_menu(l:categories, {
        \ 'title': 'EasyOps Categories',
        \ 'callback': 'easyops#menu#HandleCategorySelection',
        \ })
endfunction

function! easyops#menu#HandleCategorySelection(id, result) abort
  if a:result < 1
    return
  endif

  let l:categories = ['Git', 'Window', 'File', 'Code']
  let l:choice = l:categories[a:result - 1]

	let s:categoryCommands = {
        \ 'Git':    {'func': 'easyops#menu#git#GetMenuOptions',       'title': 'Git Commands'},
        \ 'Window': {'func': 'easyops#menu#window#GetMenuOptions',    'title': 'Window Commands'},
        \ 'File':   {'func': 'easyops#menu#file#GetMenuOptions',      'title': 'File Commands'},
        \ 'Code':   {'func': 'easyops#menu#ProjectAndLangOptions',    'title': 'Code Commands'},
        \ }

	if has_key(s:categoryCommands, l:choice)
		let l:info = s:categoryCommands[l:choice]
    let l:opts = call(l:info.func, [])
		let g:easyops_cmds = map(copy(l:opts), 'v:val[1]')
  	let l:labels = map(l:opts, {_, v -> v[0]})
    call popup_menu(l:labels, {'title': l:info.title, 'callback': 'easyops#Execute'})
  endif
endfunction

function! easyops#menu#ProjectAndLangOptions() abort
  let l:opts = []
  if exists('*easyops#project#maven#GetMenuOptions')
    call extend(l:opts, easyops#project#maven#GetMenuOptions())
  endif
  if exists('*easyops#project#npm#GetMenuOptions')
    call extend(l:opts, easyops#project#npm#GetMenuOptions())
  endif
  if exists('*easyops#project#cargo#GetMenuOptions')
    call extend(l:opts, easyops#project#cargo#GetMenuOptions())
  endif

	echom 'filetype: ' . &filetype

  if &filetype ==# 'java' && exists('*easyops#lang#java#GetMenuOptions')
    call extend(l:opts, easyops#lang#java#GetMenuOptions())
  endif
  if &filetype ==# 'javascript' && exists('*easyops#lang#javascript#GetMenuOptions')
    call extend(l:opts, easyops#lang#javascript#GetMenuOptions())
  endif
  if &filetype ==# 'rust' && exists('*easyops#lang#rust#GetMenuOptions')
    call extend(l:opts, easyops#lang#rust#GetMenuOptions())
  endif
  if &filetype ==# 'vim'
    call extend(l:opts, easyops#lang#vim#GetMenuOptions())
  endif
  return l:opts
endfunction
