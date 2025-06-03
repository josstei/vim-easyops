function! easyops#command#springboot#commands() abort
    if !exists('g:easyops_commands_springboot')
        let g:easyops_commands_springboot = [
                    \   { 'label': 'Spring Boot: Run',            'command': 'mvn spring-boot:run' },
                    \   { 'label': 'Spring Boot: Repackage',      'command': 'mvn spring-boot:repackage' },
                    \   { 'label': 'Spring Boot: Build Image',    'command': 'mvn spring-boot:build-image' },
                    \ ]
    endif

    if !exists('g:easyops_menu_springboot')
        let g:easyops_menu_springboot = {
                    \   'manifest' : 'pom.xml',
                    \   'default'  : {'maven_opts': ''},
                    \   'commands' : g:easyops_commands_springboot
                    \ }
    endif
    return g:easyops_menu_springboot
endfunction

