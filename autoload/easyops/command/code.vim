function! easyops#command#code#commands() abort
    if !exists('g:easyops_commands_code')
	    return easyops#menu#getmenuconfig(&filetype)
    else
        if !exists('g:easyops_menu_code')
            let g:easyops_menu_code= { 'commands' : g:easyops_commands_code}
        endif
        return g:easyops_menu_code
    endif
endfunction

