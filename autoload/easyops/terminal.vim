function! easyops#terminal#Execute(cmd) abort
    if has('nvim')
"         let chan_id = term_get_channel(bufnr('%'))
"         if chan_id > 0
"             call chansend(chan_id, a:cmd . "\n")
"         endif
    elseif &buftype ==# 'terminal'
        call feedkeys(a:cmd . "\r", "t")
    endif
endfunction

