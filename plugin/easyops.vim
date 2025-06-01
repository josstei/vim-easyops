if exists('g:loaded_easyops')
  finish
endif

let g:loaded_easyops = 1

command! EasyOps call easyops#menu#interactivemenu('Main','Main')

nnoremap <silent> <leader>m :EasyOps<CR>

" ***** Default Configurations *****
let g:easyops_dotfile_config = '.easyops.json'
    
let g:easyops_popup_config = {
  \ 'title'    : 'easyops',
  \ 'padding'  : [0,1,0,1],
  \ 'border'   : [],
  \ 'pos'      : 'center',
  \ 'zindex'   : 300,
  \ 'minwidth' : 2,
  \ 'mapping'  : 0,
  \ 'drag'     : 0
  \ }

let g:easyops_manifest_config = {
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

let g:easyops_language_config= {
  \ 'java': {
  \   'flags': [],
  \   'classpath': ''
  \ },
  \ }
