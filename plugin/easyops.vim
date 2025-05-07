if exists('g:loaded_easyops')
  finish
endif

let g:loaded_easyops = 1

" code menu
nnoremap <silent> <Leader>cm :call easyops#OpenMenu('')<CR>
" git menu
nnoremap <silent> <Leader>gm :call easyops#OpenMenu('git')<CR>
" file menu
" nnoremap <silent> <Leader>fm :call easyops#OpenMenu('file')<CR>
" window menu
" nnoremap <silent> <Leader>wm :call easyops#OpenMenu('window')<CR>

