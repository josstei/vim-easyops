function! easyops#config#GetDefaultJSON() abort
  let l:config = {
  \   'environment': {
  \   },
  \ }
  return json_encode(l:config)
endfunction

function! easyops#config#CreateEasyOpsConfig() abort
  let l:manifest = easyops#GetManifestFile() 
  let l:dir      = get(l:manifest,'root',getcwd()) . '/' . g:easyops_dotfile_config
  let l:default  = easyops#config#GetDefaultJSON()

  if !filereadable(l:dir)
    call writefile(split(l:default,'\n'), l:dir)
    echom g:easyops_dotfile_config .' file created at ' . l:dir
  else
    echom g:easyops_dotfile_config .' file already exists at ' . l:dir
  endif
endfunction

function! easyops#config#InitConfig() abort
    let l:manifest_file    = easyops#GetManifestFile() 
    let l:easyops_config   = easyops#config#GetEasyOpsConfig(l:manifest.root) abort
    let l:menu_config      = easyops#menu#getmenuconfig(l:manifest.type) 

    if !has_key(a:cfg, a:project_type)
        let a:cfg[a:type] = a:defaults
        let l:configState = 'config initialized in ' . l:file

        call writefile([json_encode(a:cfg)], l:file)
    else
        let l:configState = 'config already exists'
    endif

    echom 'EasyOps: ' . a:project_type . ' ' .l:configState
endfunction

function! easyops#config#LoadConfig(root) abort
  let l:cfg  = {}
  let l:file = easyops#config#GetConfig(a:root) 

  if filereadable(l:file)
    try
      let l:cfg = json_decode(join(readfile(l:file), "\n"))
    catch
    endtry
  endif

  return l:cfg
endfunction

function! easyops#config#GetEasyOpsConfig(root) abort
  return a:root . '/.easyops.json'
endfunction
