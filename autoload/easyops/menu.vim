let g:easyops_menu_main = [
			\ { 'label' : 'Git' }, 
			\ { 'label' : 'File' }, 
			\ { 'label' : 'Window' }, 
			\ { 'label' : 'Code' } 
			\	]

let s:popup_settings = {
  \ 'title': 'EasyOps',
  \ 'padding': [0,1,0,1],
  \ 'border': [],
  \ 'pos': 'center',
  \ 'zindex': 300,
  \ 'minwidth': 2,
  \ 'mapping': 0,
  \ 'drag': 0
  \ }

function! s:createPopupMenu(lines, title) abort
  let popup_id = popup_create(a:lines, s:popup_settings)
  redraw!
  call popup_close(popup_id)
  return nr2char(getchar())
endfunction

function! easyops#menu#InteractiveMenu(config,title) abort
	try
		let l:hotkeys = {}
		let l:options = []

		for i in range(len(a:config))
			let l:key = string(i + 1)
			let l:hotkeys[key] = a:config[i].label
			call add(l:options, l:key . ': ' . l:hotkeys[l:key])
		endfor
		
		let l:choice   = s:createPopupMenu(l:options, ' ' . a:title . ' ')

		if has_key(l:hotkeys, l:choice) 
			let l:test = easyops#command#GetCommands(l:hotkeys[l:choice])
			if type(l:test) == type({}) && has_key(l:test, 'commands') && type(l:test.commands) == type([]) && !empty(l:test.commands)
				call easyops#menu#InteractiveMenu(l:test.commands, 'EasyOps')
			else
				call easyops#Execute(a:config[l:choice - 1])
			endif
		else
			return ''
		endif
  catch /.*/
		echo 'EasyOps: No actions available'
		return
	endtry
endfunction

function! easyops#menu#ShowMainMenu() abort
  call easyops#menu#InteractiveMenu(g:easyops_menu_main, 'EasyOps - Main')
endfunction

" this needs to be cleaned up 
function! easyops#menu#ProjectAndLangOptions() abort
"   let opts = []

"   for project in ['maven', 'npm', 'cargo', 'bundler']
"     try
"       call extend(opts, easyops#command#GetProjectTypeOptions(project))
"     catch /.*/
"     endtry
"   endfor

  try
    return easyops#command#GetFileTypeOptions(&filetype)
  catch /.*/
  endtry

"   return opts
endfunction

function! easyops#menu#GetOptions(val) abort
  try
    return easyops#command#GetOptions(val)
  catch /.*/
  endtry
"   return opts
endfunction
