let s:cmd_newline = has('win32') || has('win64') ? "\r\n" : "\n"
function! easyops#terminal#Execute(cmd) abort
    if has('nvim')
        if exists('b:terminal_job_id')
            startinsert
            call chansend(b:terminal_job_id, a:cmd . s:cmd_newline)
        endif
    elseif &buftype ==# 'terminal'
        call feedkeys(a:cmd . "\r", "t")
    endif
endfunction

function! easyops#terminal#Close() abort
    close!
    let g:term_winid = -1
endfunction
