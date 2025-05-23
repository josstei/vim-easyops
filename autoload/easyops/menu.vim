let g:easyops_menu_main = ['Git','File','Window','Code']
let s:main_menu         = {}
let s:menuOptions       = []
let s:popup_settings = {
  \ 'title': 'EasyOps',
  \ 'padding': [0,1,0,1],
  \ 'border': [],
  \ 'pos': 'center',
  \ 'zindex': 300,
  \ 'minwidth': max(map(copy(s:menuOptions), 'len(v:val)')) + 2,
  \ 'mapping': 0,
  \ 'drag': 0
  \ }

for key in g:easyops_menu_main
  let s:main_menu[key] = {
        \ 'func'  : key ==# 'Code' ? 'easyops#menu#ProjectAndLangOptions' : 'easyops#menu#' . tolower(key) . '#GetMenuOptions',
        \ 'title' : ' ' . key . ' '
        \ }
endfor

function! s:createPopupMenu(lines, title) abort
  let popup_id = popup_create(a:lines, s:popup_settings)
  redraw!
  call popup_close(popup_id)
  return nr2char(getchar())
endfunction

function! easyops#menu#InteractiveMenu(options,title) abort
" 	try
		let l:hotkeys      = {}
		let l:menu_options = type(a:options) == type([]) ? copy(a:options) : []

		for i in range(len(l:menu_options))
			let l:key             = string(i + 1)
			let l:hotkeys[key]    = l:menu_options[i]
			let l:menu_options[i] = l:key . ': ' . l:hotkeys[l:key] 
		endfor
		
		let l:choice = s:createPopupMenu(l:menu_options, ' ' . a:title . ' ')
		return has_key(l:hotkeys, l:choice) ? l:hotkeys[l:choice] : ''
"   catch /.*/
" 		echo 'EasyOps: No actions available'
" 		return
" 	endtry
endfunction

function! easyops#menu#ShowMainMenu() abort
  let choice = easyops#menu#InteractiveMenu(g:easyops_menu_main, 'EasyOps')
  call easyops#menu#ShowSubMenu(call(s:main_menu[choice].func,[]))
endfunction

function! easyops#menu#ShowSubMenu(options) abort
		let choice = easyops#menu#InteractiveMenu(a:options,'EasyOps')
		call easyops#Execute(a:options[choice])
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

