function! easyops#lang#java#GetMenuOptions() abort
	let l:tasks   = []
	let l:pom_file    = findfile('pom.xml', '.;')
	let l:gradle_file = findfile('build.gradle', '.;')

  if !empty(l:pom_file)
    let l:pom_dir = fnamemodify(l:pom_file, ':p:h')
    let l:cd_cmd = 'cd ' . shellescape(l:pom_dir) . ' && '
		let l:config_file = l:pom_dir . '/.easyops.json'
		let l:config_exists = filereadable(l:config_file)

		if l:config_exists
			let l:config = easyops#LoadConfig(l:pom_dir)
			let l:maven_opts = get(l:config, 'maven_opts', '')
		else
			let l:maven_opts = ''
		endif

    call add(l:tasks, ['Maven: Clean',           l:cd_cmd . 'mvn ' . l:maven_opts . ' clean'])
    call add(l:tasks, ['Maven: Compile',         l:cd_cmd . 'mvn ' . l:maven_opts . ' compile'])
    call add(l:tasks, ['Maven: Test',            l:cd_cmd . 'mvn ' . l:maven_opts . ' test'])
    call add(l:tasks, ['Maven: Package',         l:cd_cmd . 'mvn ' . l:maven_opts . ' package'])
    call add(l:tasks, ['Maven: Install',         l:cd_cmd . 'mvn ' . l:maven_opts . ' install'])
    call add(l:tasks, ['Maven: Spring Boot Run', l:cd_cmd . 'mvn ' . l:maven_opts . ' spring-boot:run'])
    call add(l:tasks, ['Maven: Checkstyle',      l:cd_cmd . 'mvn ' . l:maven_opts . ' checkstyle:check'])
		if !l:config_exists
  		call add(l:tasks, ['Create EasyOps Config File', 'EASYOPS_CREATE_CONFIG'])
		endif

  endif

	if !empty(l:gradle_file)
		let l:gradle_dir = fnamemodify(l:gradle_file, ':h')
		let l:cdg = 'cd ' . shellescape(l:gradle_dir) . ' && '
		
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

