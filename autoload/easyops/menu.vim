function! easyops#menu#Open(type, title) abort
    try
        let l:configs   = easyops#menu#GetConfigList(a:type)
        let l:menu      = easyops#menu#Create(l:configs)
        let l:input     = easyops#popup#Open(l:menu.rows, ' ' . a:title . ' ')
        let l:selection = easyops#menu#GetOption(l:menu.options,l:input)

        call easyops#menu#OnSelection(l:selection, l:selection.config)
    catch /.*/
        echom 'Easyops: Menu - ['.a:title.'] ' . v:exception
    endtry
endfunction

function! easyops#menu#Create(types) abort
    let l:menu  = []
    let l:idx   = 1
    for l:type in a:types
        let l:config = easyops#menu#GetConfig(l:type)
        if !empty(l:config)
            let l:options = easyops#menu#GetOptionList(l:config)
            for l:option in l:options
                let l:row           = {}
                let l:row['label']  = l:idx . ': ' . l:option.label
                let l:row['hotkey'] = l:idx
                let l:row['cmd']    = l:option.command
                let l:row['config'] = l:config
                let l:idx          += 1
                call add(l:menu,l:row)
            endfor
        endif
    endfor
    return { 'options': l:menu, 'rows': map(copy(l:menu), {_, v -> v.label}) }
endfunction

function! easyops#menu#OnSelection(selection,config) abort
	try
		if a:selection.cmd[:4] ==# 'menu:'
			call easyops#menu#Open(a:selection.cmd[5:],a:selection.label)
		else
			call easyops#command#Execute(a:selection,a:config)
		endif
	catch
		throw 'Unable to execute selected option: ' . v:exception 
	endtry
endfunction

function! easyops#menu#GetOptionList(config) abort
    try
        return get(a:config,'commands',[{'label':'no options available'}])
    catch /.*/ 
        throw 'No options defined'
    endtry
endfunction

function! easyops#menu#GetOption(options,idx) abort
    try
        return a:options[a:idx]
    catch /.*/ 
        throw 'Invalid selection'
    endtry
endfunction

function! easyops#menu#GetConfigList(configs) abort
    try
        return map(split(a:configs, '|'), 'trim(v:val)')
    catch /.*/ 
        throw 'Invalid menu configuration'
    endtry
endfunction

function! easyops#menu#GetConfig(type) abort
    try
        let l:key    = 'easyops_menu_' . a:type
        let l:func   = 'easyops#command#' . tolower(a:type) . '#commands'
        let l:config = get(g:, l:key, {})
        return empty(l:config) ? call(function(l:func),[]) : l:config
    catch /.*/
        throw 'No menu configuration defined'
    endtry
endfunction

