function! easyops#command#code#commands() abort
	return easyops#menu#GetMenuConfig(&filetype)
endfunction

