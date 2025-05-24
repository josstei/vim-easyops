function! easyops#command#java#commands() abort
  if !exists('g:easyops_commands_java')
		let g:easyops_commands_java = [
					\	{	'label': 'Java: Compile', 'command': 'javac -d target/classes ' . expand('%') },
					\	{	'label': 'Java: Compile Project', 'command': 'javac -d target/classes $(find src/main/java -name "*.java")' } ,
					\	{	'label': 'Java: Run', 'command': 'java -cp target/classes ' . GetMainClass() }
					\	]
  endif
  if !exists('g:easyops_menu_java')
   let g:easyops_menu_java = { 'commands' : g:easyops_commands_java }
	endif
	return g:easyops_menu_java
endfunction

function! GetMainClass()
  let l:lines = readfile(expand('%'))
  let l:pkg   = ''

  for line in l:lines
    if line =~? '^package '
      let l:pkg = substitute(line, '^package\s\+\(.*\);', '\1.', '')
      break
    endif
  endfor

  return l:pkg . expand('%:t:r')
endfunction
