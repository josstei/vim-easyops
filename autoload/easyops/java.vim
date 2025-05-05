" autoload/easyops/java.vim
function! easyops#java#GetMenuOptions() abort
  let l:tasks   = []
  let l:pom_file    = findfile('pom.xml', '.;')
  let l:gradle_file = findfile('build.gradle', '.;')

  if !empty(l:pom_file)
"     let l:pom_dir = fnamemodify(l:pom_file, ':h')
		let l:pom_dir = fnamemodify(l:pom_file, ':p:h')

    let l:cd_cmd  = 'cd ' . shellescape(l:pom_dir) . ' && '

    call add(l:tasks, ['Maven: Clean',            l:cd_cmd . 'mvn clean'])
    call add(l:tasks, ['Maven: Compile',          l:cd_cmd . 'mvn compile'])
    call add(l:tasks, ['Maven: Test',             l:cd_cmd . 'mvn test'])
    call add(l:tasks, ['Maven: Package',          l:cd_cmd . 'mvn package'])
    call add(l:tasks, ['Maven: Install',          l:cd_cmd . 'mvn install'])
    call add(l:tasks, ['Maven: Spring Boot Run',  l:cd_cmd . 'mvn spring-boot:run'])
    call add(l:tasks, ['Maven: Checkstyle',       l:cd_cmd . 'mvn checkstyle:check'])
  endif

  if !empty(l:gradle_file)
    let l:gradle_dir = fnamemodify(l:gradle_file, ':h')
    let l:cdg        = 'cd ' . shellescape(l:gradle_dir) . ' && '

    call add(l:tasks, ['Gradle: Clean',          l:cdg . 'gradle clean'])
    call add(l:tasks, ['Gradle: Build',          l:cdg . 'gradle build'])
    call add(l:tasks, ['Gradle: Test',           l:cdg . 'gradle test'])
    call add(l:tasks, ['Gradle: BootRun (Spring)',l:cdg . 'gradle bootRun'])
  endif

  if empty(l:tasks)
    let l:cls = expand('%:t:r')
    let l:cwd = getcwd()
    call add(l:tasks,['Compile Current File', l:cd_cmd .#? '' : '' . 'javac ' . expand('%')])
    call add(l:tasks,['Run Current Class',    'cd ' . shellescape(l:cwd) . ' && java ' . l:cls])
  endif

  return l:tasks
endfunction

