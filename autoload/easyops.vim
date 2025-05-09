function! s:executeCommand(id, result) abort
  if a:result < 1
    return
  endif

  let l:index = a:result - 1
  let l:cmd   = g:easyops_cmds[l:index]

	" TODO - this needs to be modular and not in the core executeCommand
  if l:cmd ==# 'EASYOPS_CREATE_CONFIG'
    let l:pom = findfile('pom.xml', '.;')
    if empty(l:pom)
      echohl ErrorMsg | echom 'EasyOps: Cannot find pom.xml to determine config location.' | echohl None
      return
    endif
    let l:dir  = fnamemodify(l:pom, ':p:h')
    let l:file = l:dir . '/.easyops.json'
    if filereadable(l:file)
      echo 'EasyOps: Config already exists at ' . l:file
      return
    endif
    call writefile(['{', '  "maven_opts": ""', '}'], l:file)
    echo 'EasyOps: Created EasyOps config at ' . l:file
    return
  endif

  if get(g:, 'easyops_pause_on_exit', 0)
    let l:cmd .= ' ; echo "" ; echo "Press ENTER to close…" ; read'
  endif

  let l:esc     = substitute(l:cmd, '"', '\\"', 'g')
  let l:full    = printf('%s %s "%s"', &shell, &shellcmdflag, l:esc)

  execute 'belowright terminal ++close ' . l:full
endfunction

function! easyops#LoadConfig(dir) abort
	let l:config_file = a:dir . '/.easyops.json'
	if filereadable(l:config_file)
		let l:content = join(readfile(l:config_file), "\n")
		try
			let l:cfg = json_decode(l:content)
			return l:cfg
		catch /^Vim\%((\a\+)\)\=:E\w\+/
			echohl WarningMsg
			echom 'EasyOps: Failed to parse ' . l:config_file
			echohl None
			return {}
		endtry
	endif
	return {}
endfunction

" TODO - break out portions of this into separate functions to make it a bit
" more readable
function! easyops#OpenMenu(menuType) abort
	let s:default_ft_map = {
		\ 'javascriptreact': 'javascript',
		\ 'javascript'     : 'javascript',
		\ 'java'           : 'java',
		\ 'c'              : 'cpp',
		\ 'cpp'            : 'cpp',
		\ 'c++'            : 'cpp',
		\ }

	let s:ft_map = extend(copy(s:default_ft_map),get(g:, 'easyops_filetype_map', {}), 'keep')

	if a:menuType !=# ''
		let l:ctx = a:menuType
		let l:mod = 'menu'
	else
		let l:ctx = get(s:ft_map, &filetype, '')
		if empty(l:ctx)
			echohl ErrorMsg | echom 'EasyOps: No menu for filetype "' . &filetype . '"' | echohl None
			return
		endif
		let l:mod = 'lang'
	endif

	let l:fn = printf('easyops#%s#%s#GetMenuOptions', l:mod, l:ctx)
	let l:tasks = s:getTasks(l:fn,l:ctx)
	let g:easyops_cmds = map(copy(l:tasks), 'v:val[1]')
	let l:menu_items = map(copy(l:tasks), 'v:val[0]')

	if exists('*popup_menu')
		call popup_menu(l:menu_items, #{ title: 'EasyOps: ' . l:ctx, callback: 's:executeCommand' })
	else
		let l:choices = ['Select action:'] + map(copy(l:menu_items), { i, v -> printf('%d. %s', i+1, v) })
		let l:choice = inputlist(l:choices)
		if l:choice >= 1 && l:choice <= len(g:easyops_cmds)
			execute 'terminal ' . g:easyops_cmds[l:choice - 1]
		endif
	endif
endfunction

function s:getTasks(fn,ctx) abort
	try 
		return call(a:fn, [])
	catch /^Vim\%((\a\+)\)\=:E117/ 
		echohl ErrorMsg | echom 'EasyOps: No menu defined for context "' . a:ctx . '"' | echohl None
		return
	endtry
	if empty(l:tasks)
		echohl WarningMsg | echom 'EasyOps: No actions defined for "' . l:ctx . '"' | echohl None
		return
	endif
endfunction
