function! easyops#config#CreateEasyOpsConfig() abort
    let l:dir = easyops#config#GetEasyOpsConfig()

    if !filereadable(l:dir)
        call writefile(split(json_encode(g:easyops_dotfile_default),'\n'), l:dir)
        call easyops#config#PrintCreateMessage('created',l:dir) 
    else
        call easyops#config#PrintCreateMessage('exists',l:dir) 
    endif
endfunction

function! easyops#config#PrintCreateMessage(message,dir) 
    echom g:easyops_dotfile_config .' file ' . a:message ' at '  . a:dir
endfunction

function! easyops#config#GetEasyOpsConfig() abort
    let l:manifest = easyops#GetManifestFile() 
    return get(l:manifest,'root',getcwd()) . '/' . g:easyops_dotfile_config
endfunction

function! easyops#config#LoadEasyOpsConfig() abort
    let l:file = expand(easyops#config#GetEasyOpsConfig())
    if filereadable(l:file)
        let l:json = join(readfile(l:file), "\n")
        let l:data = json_decode(l:json)

        if has_key(l:data, 'environment')
            let g:easyops_env = l:data.environment
        else
            echoerr "No 'environment' key found in .easyops.json"
        endif
    endif
endfunction
