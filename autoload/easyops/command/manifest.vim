function! easyops#command#manifest#commands() abort
	let l:manifest = easyops#GetManifestFile()
    return !empty(l:manifest) ? easyops#menu#getmenuconfig(l:manifest.type) : l:manifest 
endfunction
