if exists('g:loaded_easyops')
  finish
endif
let g:loaded_easyops = 1

" initially just for code, will expand to files and windows
nnoremap <silent> <Leader>cm :call easyops#OpenMenu()<CR>
" nnoremap <silent> <Leader>fm :call easyops#OpenMenu()<CR>
" nnoremap <silent> <Leader>gm :call easyops#OpenMenu()<CR>

