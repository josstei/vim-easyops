let s:main_menu_options = ['Git', 'Window', 'File', 'Code']
let s:main_menu = {}

for key in s:main_menu_options
  let s:main_menu[key] = {
        \ 'func': key ==# 'Code' ? 'easyops#menu#ProjectAndLangOptions' : 'easyops#menu#' . tolower(key) . '#GetMenuOptions',
        \ 'title': ' ' . key . ' '
        \ }
endfor

function! easyops#menu#ShowCategories() abort
  call popup_menu(s:main_menu_options, { 'title': ' EasyOps', 'callback': 'easyops#menu#HandleCategorySelection' })
endfunction

function! easyops#menu#HandleCategorySelection(id, result) abort
  if a:result < 1 | return | endif

  let l:choice = s:main_menu_options[a:result - 1]
  let l:info   = s:main_menu[l:choice]
  let l:opts   = call(l:info.func, [])

  let g:easyops_cmds     = map(copy(l:opts), 'v:val[1]')
  let l:sub_menu_options = map(copy(l:opts), 'v:val[0]')

  call popup_menu(l:sub_menu_options, { 'title': l:info.title, 'callback': 'easyops#Execute' })
endfunction

function! easyops#menu#ProjectAndLangOptions() abort
  let l:opts = []

  for project in ['maven', 'npm', 'cargo', 'bundler']
    try
      call extend(l:opts, easyops#command#GetProjectTypeOptions(project))
    catch /.*/
    endtry
  endfor

  try
    call extend(l:opts, easyops#command#GetFileTypeOptions(&filetype))
  catch /.*/
  endtry

  return l:opts
endfunction
