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
	let s:popup_settings['title'] = a:title
  let popup_id = popup_create(a:lines, s:popup_settings)
  redraw!
  call popup_close(popup_id)
  return nr2char(getchar())
endfunction

function! easyops#menu#InteractiveMenu(config,title) abort
	try
		let l:hotkeys  = {}
		let l:options  = []
		let l:commands = easyops#command#GetCommands(a:config).commands

		for i in range(len(l:commands))
			let l:key          = string(i + 1 )
			let l:hotkeys[key] = l:commands[i].label

			call add(l:options, l:key . ': ' . l:hotkeys[l:key])
		endfor
		
		let l:choice = s:createPopupMenu(l:options, ' ' . a:title . ' ')

		if !has_key(l:hotkeys, l:choice) 
			echo 'EasyOps: Not a valid selection'
			return
		endif 

		let l:selection = l:commands[l:choice - 1]

		if has_key(l:selection,'command')
			call easyops#Execute(l:selection)
		else
			call easyops#menu#InteractiveMenu(l:selection.label,l:selection.label)
		endif
  catch /.*/
		echo 'EasyOps: No actions available'
		return
	endtry
endfunction

function! easyops#menu#ShowMainMenu() abort
  call easyops#menu#InteractiveMenu('main', 'EasyOps')
endfunction
