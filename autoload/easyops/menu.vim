let s:popup_config = {
  \ 'title'    : 'EasyOps',
  \ 'padding'  : [0,1,0,1],
  \ 'border'   : [],
  \ 'pos'      : 'center',
  \ 'zindex'   : 300,
  \ 'minwidth' : 2,
  \ 'mapping'  : 0,
  \ 'drag'     : 0
  \ }

function! s:createPopupMenu(lines, title) abort
  let l:popup_config          = copy(s:popup_config)
  let l:popup_config['title'] = a:title
  let l:popup                 = popup_create(a:lines, l:popup_config)

  redraw

  let l:key = getchar()
  call popup_close(l:popup)

	if type(l:key) == v:t_number
    return l:key - char2nr('1')
  endif
endfunction

function! easyops#menu#InteractiveMenu(type,title) abort
	try
		let l:menu_config  = easyops#menu#GetMenuConfig(a:type)
		let l:menu_options = easyops#menu#GetMenuOptions(l:menu_config)
		let l:menu_rows    = easyops#menu#SetMenuRows(l:menu_options) 
		let l:selection    = easyops#menu#GetMenuSelection(l:menu_options,l:menu_rows,a:title)

		call easyops#menu#ExecuteMenuSelection(l:selection,l:menu_config)
  catch /.*/
		echo 'EasyOps: Menu - ['.a:title.'] ' . v:exception
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

function!easyops#menu#ExecuteMenuSelection(selection,config) abort
	try
		if a:selection.command[:4] ==# 'menu:'
			call easyops#menu#InteractiveMenu(a:selection.command[5:],a:selection.label)
		else
			call easyops#command#ExecuteCommand(a:selection,a:config)
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
