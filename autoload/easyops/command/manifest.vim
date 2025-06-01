function! easyops#command#manifest#commands() abort
	let l:manifest = easyops#getmanifestfile()
	return easyops#menu#getmenuconfig(l:manifest.type)
endfunction
