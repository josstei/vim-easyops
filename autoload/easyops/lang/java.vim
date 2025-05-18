function! easyops#lang#java#GetMenuOptions() abort
  let l:tasks = []
  let l:file  = expand('%:p')

	call add(l:tasks, ['Java: Compile', 'javac -d target/classes ' . expand('%')])
	call add(l:tasks, ['Java: Compile Project', 'javac -d target/classes $(find src/main/java -name "*.java")'])
	call add(l:tasks, ['Java: Run (java)', 'java -cp target/classes ' . GetMainClass()])

  return l:tasks
endfunction

function! GetMainClass()
  let l:lines = readfile(expand('%'))
  let l:pkg = ''

  for line in l:lines
    if line =~? '^package '
      let l:pkg = substitute(line, '^package\s\+\(.*\);', '\1.', '')
      break
    endif
  endfor

  return l:pkg . expand('%:t:r')
endfunction
