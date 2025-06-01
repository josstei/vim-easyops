if exists('g:loaded_easyops_core')
  finish
endif

let g:loaded_easyops_core = 1

function! easyops#GetManifestFile() abort
	for [l:type, l:pattern] in items(g:easyops_manifest_config)
		let l:manifest = findfile(l:pattern,'.;')
		if !empty(l:manifest)
	        let l:default = ''
	        let l:root    = fnamemodify(l:manifest,':p:h')
			return {'type': l:type , 'root': l:root , 'manifest': l:manifest}
		endif
	endfor
    return {}
endfunction
