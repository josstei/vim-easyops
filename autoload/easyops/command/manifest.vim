let g:easyops_manifest_files = {
   \ 'maven':          'pom.xml',
   \ 'gradle':         'build.gradle',
   \ 'gradle_kts':     'build.gradle.kts',
   \ 'sbt':            'build.sbt',
   \ 'npm':            'package.json',
   \ 'pnpm':           'pnpm-lock.yaml',
   \ 'bun':            'bun.lockb',
   \ 'poetry':         'pyproject.toml',
   \ 'pipenv':         'Pipfile',
   \ 'setuptools':     'setup.py',
   \ 'rust':           'Cargo.toml',
   \ 'go':             'go.mod',
   \ 'dotnetcs':       '*.csproj',
   \ 'dotnetfs':       '*.fsproj',
   \ 'dotnetvb':       '*.vbproj',
   \ 'cmake':          'CMakeLists.txt',
   \ 'make':           'Makefile',
   \ 'meson':          'meson.build',
   \ 'docker':         'Dockerfile',
   \ 'docker_compose': 'docker-compose.yml',
   \ 'helm':           'Chart.yaml',
   \ 'kubernetes':     '*.yaml',
   \ 'nextjs':         'next.config.js',
   \ 'vite':           'vite.config.ts',
   \ 'nuxt':           'nuxt.config.ts',
   \ 'gatsby':         'gatsby-config.js',
   \ 'sveltekit':      'svelte.config.js',
   \ 'astro':          'astro.config.mjs'
   \ }

function! easyops#command#manifest#commands() abort
	for [l:type, l:pattern] in items(g:easyops_manifest_files)
		let l:manifest = findfile(l:pattern,'.;')
		if !empty(l:manifest)
			return easyops#menu#getmenuconfig(l:type)
		endif
	endfor
  return {}
endfunction
