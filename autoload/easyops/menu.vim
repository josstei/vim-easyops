function! easyops#menu#ShowCategories() abort
	let l:categories= [
        \ 'Git ▶',
        \ 'Window ▶',
        \ 'File ▶',
        \ 'Code ▶',
        \ ]

  if !filereadable(getcwd() . '/.easyops.json')
    call add(l:categories, 'Create EasyOps Config')
  endif

	call popup_menu(l:categories, {
        \ 'title': ' EasyOps ',
        \ 'callback': 'easyops#menu#HandleCategorySelection',
        \ })

endfunction

function! easyops#menu#HandleCategorySelection(id, result) abort
  if a:result < 1
    return
  endif

	let l:categories     = ['Git', 'Window', 'File', 'Code','Create EasyOps Config']
	let l:choice         = l:categories[a:result - 1]
	let s:menuOptionsMap = {
        \ 'Git':    {'func': 'easyops#menu#git#GetMenuOptions',       'title': ' Git '},
        \ 'Window': {'func': 'easyops#menu#window#GetMenuOptions',    'title': ' Window '},
        \ 'File':   {'func': 'easyops#menu#file#GetMenuOptions',      'title': ' File '},
        \ 'Code':   {'func': 'easyops#menu#ProjectAndLangOptions',    'title': ' Code '},
        \ }

  if l:choice ==# 'Create EasyOps Config'
    call easyops#menu#CreateConfigFile()
    return
  endif

	if has_key(s:menuOptionsMap, l:choice)
		let l:info = s:menuOptionsMap[l:choice]
    let l:opts = call(l:info.func, [])
		let g:easyops_cmds = map(copy(l:opts), 'v:val[1]')
  	let l:labels = map(l:opts, {_, v -> v[0]})
    call popup_menu(l:labels, {'title': l:info.title, 'callback': 'easyops#Execute'})
  endif
endfunction

function! easyops#menu#ProjectAndLangOptions() abort
  let l:opts = []

  for project in ['maven', 'npm', 'cargo']
    try
      let l:func = 'easyops#project#' . project. '#GetMenuOptions'
      call extend(l:opts, call(l:func, []))
    catch /.*/
    endtry
  endfor

  try
    let l:lang_func = 'easyops#lang#' . &filetype . '#GetMenuOptions'
    call extend(l:opts, call(l:lang_func, []))
  catch /.*/
  endtry

  return l:opts
endfunction

function! easyops#menu#CreateConfigFile() abort
  let l:path = getcwd() . '/.easyops.json'

  if filereadable(l:path)
    echom 'EasyOps Config already exists at ' . l:path
    return
  endif

  let l:default_config = { "environment": {}}

  call writefile([json_encode(l:default_config)], l:path)
  echom 'EasyOps Config created at ' . l:path
endfunction
