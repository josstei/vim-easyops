function! easyops#popup#GetConfig(lines,title) abort
        let l:width         = 0
        let l:height        = len(a:lines)
        let l:width_key     = g:easyops_nvim ? 'width'  : 'minwidth'
        let l:height_key    = g:easyops_nvim ? 'height' : 'minheight'
        let l:border        = g:easyops_nvim ? 'single' : []

        for line in a:lines
            let l:width = max([l:width, strwidth(line)])
        endfor

        let l:width += 4

        let l:config = {}
        let l:config['title'] = a:title
        let l:config['border'] = l:border
        let l:config[l:width_key] = l:width
        let l:config[l:height_key] = l:height

        if g:easyops_nvim
            let l:row     = (&lines - l:height) / 2
            let l:col     = (&columns - l:width) / 2

            let l:config['relative']    = 'editor'
            let l:config['style']       = 'minimal'
            let l:config['row']         = l:row 
            let l:config['col']         = l:col
        else
            let l:config['pos']     = 'center'
            let l:config['zindex']  = 300
            let l:config['padding'] = [0,1,0,1]
            let l:config['mapping'] = 0
            let l:config['drag']    = 0
        endif
        return l:config
endfunction

function! easyops#popup#Open(lines, title) abort
    let l:config    = easyops#popup#GetConfig(a:lines,a:title)
    let l:popup     = easyops#popup#Create(a:lines, l:config)
    let l:input     = easyops#popup#GetInput(a:lines)
    call easyops#popup#Close(l:popup) | return l:input
endfunction

function! easyops#popup#Create(lines, config) abort
    if has('nvim')
        let l:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(l:buf, 0, -1, v:false, a:lines)
        let l:popup = nvim_open_win(l:buf, v:true, a:config)
    else
        let l:popup = popup_create(a:lines, a:config)
    endif
    redraw
    return l:popup
endfunction

function! easyops#popup#Close(popup) abort
    if has('nvim')
        call nvim_win_close(a:popup, v:true)
    else
        call popup_close(a:popup)
    endif
endfunction

function easyops#popup#GetInput(lines)
    let l:input = len(a:lines) < 10 ? easyops#popup#GetInputSingle() : easyops#popup#GetInputMulti()
    return l:input
endfunction

function! easyops#popup#ValidateInput(input)
    if type(a:input) != v:t_number || a:input == 27 || a:input == char2nr('q')
        return -1
    endif
    return a:input
endfunction

function! easyops#popup#GetInputSingle() 
    return easyops#popup#ValidateInput(getchar()) - char2nr('1')
endfunction

function! easyops#popup#GetInputMulti() abort
    let input = ''

    while 1 
        let key = getchar(0)
            
        if key == 0
            if !empty(input) && reltimefloat(reltime(last)) > 0.3 | break | endif
            sleep 10m | continue
        endif
            
        let last   = reltime()
        let input .= nr2char(easyops#popup#ValidateInput(key))
    endwhile

    return str2nr(input) - 1
endfunction
