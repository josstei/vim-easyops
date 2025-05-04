" Command Menu Plugin (vimscript)
" ==================================
"
" A modular popup menu for build/test/clean commands per filetype.
" Languages live in separate files under autoload/command_menu/<lang>.vim
"
" Directory structure:
" ├── plugin/
" │   └── command_menu.vim
" └── autoload/
"     └── command_menu/
"         └── java.vim
"
" plugin/command_menu.vim
" ------------------------
" Entry point: map <leader>cm to dispatcher

if exists('g:loaded_command_menu')
  finish
endif
let g:loaded_command_menu = 1

" Map leader command
nnoremap <silent> <leader>cm :call command_menu#dispatch()<CR>

" autoload/command_menu/dispatch.vim
" ----------------------------------
" The dispatcher detects filetype and delegates

define function!
function! command_menu#dispatch() abort
  let lang = &filetype
  " Build module name: command_menu#lang#menu
  let module = 'command_menu#'.lang.'#menu'
  if exists('*'.module)
    call call(function(module), [])
  else
    echohl WarningMsg
    echomsg 'command-menu: No menu defined for filetype: '.lang
    echohl None
  endif
endfunction

" autoload/command_menu/java.vim
" ------------------------------
" Java-specific menu implementation

define function!
function! command_menu#java#menu() abort
  let items = [
        \ 'Maven: compile',
        \ 'Maven: test',
        \ 'Maven: clean',
        \ 'Gradle: build',
        \ 'Gradle: clean',
        \ ]
  " Prompt title
  let title = '📦 Java Commands:'
  let choice = inputlist([title] + items)
  if choice <= 0
    return
  endif
  let sel = items[choice - 1]
  " Map selection to cmd
  if sel =~ '^Maven:'
    let cmd = 'mvn '.trim(split(sel, ':')[1])
  elseif sel =~ '^Gradle:'
    let cmd = 'gradle '.trim(split(sel, ':')[1])
  else
    let cmd = sel
  endif
  exec 'belowright split | terminal '.cmd
endfunction

