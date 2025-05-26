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
	let s:popup_settings['title'] = a:title
  let popup_id = popup_create(a:lines, s:popup_settings)
  redraw!
  call popup_close(popup_id)
  return nr2char(getchar()) - 1
endfunction

function! easyops#menu#InteractiveMenu(type,title) abort
	try
		let l:menu_options = {}
		let l:menu_rows    = []
		let l:menu    = easyops#menu#GetMenuConfig(a:type)
		let l:options = easyops#menu#GetMenuOptions(l:menu)

		for i in range(len(l:options))
			let l:menu_options[i] = easyops#menu#GetMenuOption(l:options,i)
			call add(l:menu_rows, i + 1 . ': ' . l:menu_options[i].label)
		endfor

		let l:selection = easyops#menu#GetMenuSelection(l:menu_options,l:menu_rows,a:title)

		call easyops#menu#ExecuteMenuSelection(l:selection)
  catch /.*/
		echo 'EasyOps: Menu - ['.a:title.'] ' . v:exception
		return
	endtry
endfunction

function! easyops#menu#ShowMainMenu() abort
  call easyops#menu#InteractiveMenu('main', 'EasyOps')
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
