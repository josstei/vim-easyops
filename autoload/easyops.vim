if exists('g:loaded_easyops_core')
  finish
endif

let g:loaded_easyops_core = 1

function! easyops#getmanifestfile() abort
	for [l:type, l:pattern] in items(g:easyops_manifest_files)
		let l:manifest = findfile(l:pattern,'.;')
		if !empty(l:manifest)
			return {'type': l:type , 'manifest': l:manifest }
		endif
	endfor
	return -1
endfunction
