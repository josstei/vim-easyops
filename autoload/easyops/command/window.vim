function! easyops#command#window#commands() abort
    if !exists('g:easyops_commands_window')
        let g:easyops_commands_window = [
                    \   { 'label': 'Window: Split Horizontal','command': ':rightbelow split new' },
                    \   { 'label': 'Window: Split Vertical','command': ':rightbelow vs new' }
                    \]
    endif
    if !exists('g:easyops_menu_window')
        let g:easyops_menu_window= { 'commands' : g:easyops_commands_window}
    endif
    return g:easyops_menu_window
endfunction
