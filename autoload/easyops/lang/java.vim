function! easyops#lang#java#config() abort
  if !exists('g:easyops_commands_java')
		let g:easyops_commands_java = {
					\		'Java: Compile':         'javac -d target/classes ' . expand('%'),
					\		'Java: Compile Project': 'javac -d target/classes $(find src/main/java -name "*.java")',
					\		'Java: Run':             'java -cp target/classes ' . GetMainClass()
					\	}
  endif

  if !exists('g:easyops_config_java')
    let g:easyops_config_java = { 'commands' : g:easyops_commands_java }
  endif

  return g:easyops_config_java
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
