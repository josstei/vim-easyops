function! s:createpopupmenu(lines, title) abort
    let l:config        = copy(g:easyops_popup_config) 
    let l:config.title  = a:title
    let l:popup         = popup_create(a:lines, l:config)
    redraw
    let l:count         = len(a:lines)
    let l:result        = easyops#menu#GetInput(l:count)

    call popup_close(l:popup)

    if l:result == -1  | throw 'Menu Closed' | endif	
    return l:result
endfunction

function easyops#menu#GetInput(count)
    if a:count < 10
        return easyops#menu#GetInputSingle(a:count)
    else
        return easyops#menu#GetInputMulti(a:count)
     endif
endfunction

function! easyops#menu#ValidateInput(key)
    if type(a:key) != v:t_number | return -1 | endif
    if a:key == 27               | return -1 | endif
	if a:key == char2nr('q')     | return -1 | endif
	return a:key
endfunction

function! easyops#menu#GetInputSingle(count) 
    return easyops#menu#ValidateInput(getchar()) - char2nr('1')
endfunction

function! easyops#menu#GetInputMulti(count) abort
    let input = ''

    while 1 
        let key = getchar(0)
            
        if key == 0
            if !empty(input) && reltimefloat(reltime(last)) > 0.3 | break | endif
            sleep 10m | continue
        endif
            
        let last   = reltime()
        let input .= nr2char(easyops#menu#ValidateInput(key))
    endwhile

    return str2nr(input) - 1
endfunction

function! easyops#menu#interactivemenu(type, title) abort
    try
        let l:configs   = easyops#menu#getmenuconfigs(a:type)
        let l:menu      = easyops#menu#initmenu(l:configs)
        let l:input     = s:createpopupmenu(l:menu.rows, ' ' . a:title . ' ')
        let l:selection = easyops#menu#getmenuoption(l:menu.options,l:input)

        call easyops#menu#executemenuselection(l:selection, l:selection.config)
    catch /.*/
        echom 'Easyops: Menu - ['.a:title.'] ' . v:exception
    endtry
endfunction

function! easyops#menu#initmenu(types) abort
    let l:options = []
    for l:type in a:types
        call easyops#menu#addmenuoptions(l:options,l:type)
    endfor
    let l:rows = map(copy(l:options), {idx, val -> (idx + 1) . ': ' . val.label})
    return { 'options': l:options, 'rows' : l:rows }
endfunction

function! easyops#menu#addmenuoptions(menu,type) abort
    let l:config  = easyops#menu#getmenuconfig(a:type)
    if !empty(l:config)
        for l:opt in easyops#menu#getmenuoptions(l:config)
            call add(a:menu, {'label': l:opt.label,'command': l:opt.command,'config': l:config})
        endfor
    endif
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
        let l:func   = 'easyops#command#' . tolower(a:type) . '#commands'
        let l:config = get(g:, l:key, {})
        return empty(l:config) ? call(function(l:func),[]) : l:config
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
