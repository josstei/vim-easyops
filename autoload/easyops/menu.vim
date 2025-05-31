let s:popup_config = {
  \ 'title'    : 'easyops',
  \ 'padding'  : [0,1,0,1],
  \ 'border'   : [],
  \ 'pos'      : 'center',
  \ 'zindex'   : 300,
  \ 'minwidth' : 2,
  \ 'mapping'  : 0,
  \ 'drag'     : 0
  \ }

function! s:createpopupmenu(lines, title) abort
  let l:config       = copy(s:popup_config)
  let l:config.title = a:title
  let l:popup        = popup_create(a:lines, l:config)
  redraw
  let l:count  = len(a:lines)
  let l:result = l:count < 10 ? s:get_single_digit_selection(l:count) : s:get_multi_digit_selection(l:count)

  call popup_close(l:popup)

	if l:result == -1  | throw 'Menu Closed' | endif	
  return l:result
endfunction

function! s:validatepopupinput(key)
  if type(a:key) != v:t_number | return -1 | endif
  if a:key == 27               | return -1 | endif
	if a:key == char2nr('q')     | return -1 | endif
	return a:key
endfunction

function! s:get_single_digit_selection(count) abort
	return s:validatepopupinput(getchar()) - char2nr('1')
endfunction

function! s:get_multi_digit_selection(count) abort
  let input = ''

  while 1 
    let key = getchar(0)
		
    if key == 0
      if !empty(input) && reltimefloat(reltime(last)) > 0.3 | break | endif
      sleep 10m | continue
    endif
		
    let last   = reltime()
		let input .= nr2char(s:validatepopupinput(key))
  endwhile

  return str2nr(input) - 1
endfunction

function! easyops#menu#interactivemenu(type, title) abort
  try
    let l:configs   = easyops#menu#getmenuconfigs(a:type)
    let l:menu      = easyops#menu#buildmenu(l:configs)
    let l:entry     = s:createpopupmenu(l:menu.rows, ' ' . a:title . ' ')
		let l:selection = easyops#menu#getmenuoption(l:menu.options,l:entry)

    call easyops#menu#executemenuselection(l:selection, l:selection.config)

  catch /.*/
		echom 'Easyops: Menu - ['.a:title.'] ' . v:exception
  endtry
endfunction

function! easyops#menu#buildmenu(types) abort
  let l:options = []
  for l:type in a:types
		call easyops#menu#addmenuoptions(l:options,l:type)
  endfor
	let l:rows = map(copy(l:options), {idx, val -> (idx + 1) . ': ' . val.label})

  return { 'options': l:options, 'rows' : l:rows }
endfunction

function! easyops#menu#addmenuoptions(menu,type) abort
  let l:config  = easyops#menu#getmenuconfig(a:type)
  for l:opt in easyops#menu#getmenuoptions(l:config)
    call add(a:menu, {'label': l:opt.label,'command': l:opt.command,'config': l:config})
  endfor
endfunction

function! easyops#menu#executemenuselection(selection,config) abort
	try
		if a:selection.command[:4] ==# 'menu:'
			call easyops#menu#interactivemenu(a:selection.command[5:],a:selection.label)
		else
			call easyops#command#executecommand(a:selection,a:config)
		endif
	catch
		throw 'Unable to execute selected option: ' . v:exception 
	endtry
endfunction

function! easyops#menu#getmenuconfig(type) abort
  try
    let l:key    = 'easyops_menu_' . a:type
    let l:config = get(g:, l:key, v:null)

    if l:config is# v:null
      let l:func   = 'easyops#command#' . tolower(a:type) . '#commands'
      let l:config = call(function(l:func), [])
    endif

    if empty(l:config) | throw 'No menu configuration defined' | endif

    return l:config
  catch /.*/
    throw 'No menu configuration defined'
  endtry
endfunction

function! easyops#menu#getmenuoptions(config) abort
  try
		return get(a:config,'commands',[{'label':'no options available'}])
  catch /.*/ 
		throw 'No options defined'
  endtry
endfunction

function! easyops#menu#getmenuoption(options,idx) abort
  try
		return a:options[a:idx]
  catch /.*/ 
		throw 'Invalid selection'
  endtry
endfunction

function! easyops#menu#getmenuconfigs(configs) abort
	try
	return map(split(a:configs, '|'), 'trim(v:val)')
  catch /.*/ 
		throw 'Invalid menu configuration'
  endtry
endfunction
