if exists('g:loaded_easyops')
  finish
endif

let g:loaded_easyops = 1

command! EasyOps call easyops#menu#ShowMainMenu()

nnoremap <silent> <leader>m :EasyOps<CR>

