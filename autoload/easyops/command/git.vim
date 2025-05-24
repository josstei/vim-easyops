function! easyops#command#git#commands() abort
  if !exists('g:easyops_commands_git')
		let g:easyops_commands_git = [
      \ { 'label': 'Git: Status',        'command': 'git status' },
      \ { 'label': 'Git: Add All',       'command': 'git add --all' },
      \ { 'label': 'Git: Commit',        'command': 'git commit' },
      \ { 'label': 'Git: Pull',          'command': 'git pull' },
      \ { 'label': 'Git: Push',          'command': 'git push' },
      \ { 'label': 'Git: Log (Paged)',   'command': 'git --no-pager log --oneline --graph' },
      \ { 'label': 'Git: Fetch',         'command': 'git fetch' },
      \ { 'label': 'Git: Branches',      'command': 'git branch -a' },
      \ { 'label': 'Git: Checkout...',   'command': 'git checkout ' }
      \ ]
  endif
  if !exists('g:easyops_menu_git')
   let g:easyops_menu_git = { 'commands' : g:easyops_commands_git }
	endif
	return g:easyops_menu_git
endfunction
