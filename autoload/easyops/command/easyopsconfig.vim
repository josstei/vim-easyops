function! easyops#command#easyopsconfig#commands() abort
    if !exists('g:easyops_commands_easyopsconfig')
        let g:easyops_commands_easyopsconfig = [
                    \   {	'label': 'Config: Initialize Config', 'command': ':call easyops#config#CreateEasyOpsConfig()' }
                    \]
    endif
    if !exists('g:easyops_menu_easyopsconfig')
        let g:easyops_menu_easyopsconfig = { 'commands' : g:easyops_commands_easyopsconfig}
    endif
    return g:easyops_menu_easyopsconfig
endfunction
