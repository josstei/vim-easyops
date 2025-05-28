let s:popup_settings = {
  \ 'title': 'EasyOps',
  \ 'padding': [0,1,0,1],
  \ 'border': [],
  \ 'pos': 'center',
  \ 'zindex': 300,
  \ 'minwidth': 2,
  \ 'mapping': 0,
  \ 'drag': 0
  \ }

function! s:createPopupMenu(lines, title) abort
  let popup_settings = copy(s:popup_settings)
  let popup_settings['title'] = a:title
  let popup_menu = popup_create(a:lines, popup_settings)
  redraw

  let key = getchar()
  call popup_close(popup_menu)

	if type(key) == v:t_number
    return key - char2nr('1')
  endif
endfunction

function! easyops#menu#InteractiveMenu(type,title) abort
	try
		let l:menu_options = {}
		let l:menu      = easyops#menu#GetMenuConfig(a:type)
		let l:options   = easyops#menu#GetMenuOptions(l:menu)
		let l:menu_rows = easyops#menu#SetMenuRows(l:options) 
		let l:selection = easyops#menu#GetMenuSelection(l:options,l:menu_rows,a:title)

		call easyops#menu#ExecuteMenuSelection(l:selection)
  catch /.*/
		echo 'EasyOps: Menu - ['.a:title.'] ' . v:exception
		return
	endtry
endfunction

function!easyops#menu#SetMenuRows(options) abort
	try
		let l:rows = []
		for i in range(len(a:options))
			let l:option = easyops#menu#GetMenuOption(a:options,i)
			call add(l:rows, i + 1 . ': ' . l:option.label)
		endfor
		return l:rows
	catch
		throw 'Invalid Selection'
	endtry
endfunction

function!easyops#menu#ExecuteMenuSelection(choice) abort
	try
		if a:choice.command[:4] ==# 'menu:'
			call easyops#menu#InteractiveMenu(a:choice.command[5:],a:choice.label)
		else
			call easyops#Execute(a:choice)
		endif
	catch
		throw 'Unable to execute selected option: ' . v:exception 
	endtry
endfunction

function!easyops#menu#GetMenuSelection(options,rows,title) abort
	try
		return a:options[s:createPopupMenu(a:rows, ' ' . a:title. ' ')]
	catch
		throw 'Invalid Selection'
	endtry
endfunction

function! easyops#menu#GetMenuConfig(type) abort
  try
		let l:func   = 'easyops#command#' . tolower(a:type) . '#commands'
		let l:config = get(g:, 'easyops_menu_'.a:type,{})

		return empty(l:config) ? call(function(l:func),[]) : l:config
  catch /.*/ 
		throw 'No menu configuration defined'
  endtry
endfunction

function! easyops#menu#GetMenuOptions(menu) abort
  try
		return a:menu.commands
  catch /.*/ 
		throw 'No options defined'
  endtry
endfunction

function! easyops#menu#GetMenuOption(options,idx) abort
  try
		return a:options[a:idx]
  catch /.*/ 
		throw 'Invalid option configuration'
  endtry
endfunction
