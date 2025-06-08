function! easyops#buffer#Get() abort
    let g:prev_winid = win_getid()
    if !bufexists(g:term_bufnr) || !buflisted(g:term_bufnr)
        botright terminal
        let g:term_bufnr = bufnr('%')
    else
        botright split
        execute 'buffer' g:term_bufnr
    endif
    resize 15
    let g:term_winid = win_getid()
endfunction

function! easyops#buffer#Rename(label) abort
"     execute 'file ' . string(a:label)
endfunction
