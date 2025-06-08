function! easyops#terminal#Execute(cmd) abort
    if has('nvim')
        if exists('b:terminal_job_id')
            startinsert
            call chansend(b:terminal_job_id, a:cmd . "\n")
        endif
    elseif &buftype ==# 'terminal'
        call feedkeys(a:cmd . "\r", "t")
    endif
endfunction

function! easyops#terminal#Close() abort
    close!
    let g:term_winid = -1
endfunction
