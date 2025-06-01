function! easyops#command#manifest#commands() abort
	let l:manifest_file = easyops#getmanifestfile()
	return easyops#menu#getmenuconfig(l:manifest_file.type)
endfunction
