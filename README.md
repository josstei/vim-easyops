![Stable](https://img.shields.io/badge/status-stable-brightgreen) ![License](https://img.shields.io/badge/license-MIT-blue)

# vim-easyops

`vim-easyops` is a Vim/Neovim plugin that delivers a unified, extensible menu for common development tasks—making it painless to work with files, projects, and version control within Vim. It detects your project type and loads context-aware menus for Git, Java, Rust, npm, Maven, Bundler, and more.

---

## Features

- **Unified Command Palette:** Access all operations with a single command.
- **Project Manifest Detection:** Automatically detects project type and sets up relevant commands.
- **Preset Menus:** Built-in menus for Git, Java, Maven, Rust, npm, Bundler, and more.
- **Language & Tool Support:** Java, Rust, Node.js, Python, .NET, Docker, and more.
- **File Management:** Save, quit, and force-quit files easily.
- **Git Integration:** Perform common Git operations from within Vim.
- **Build & Run:** Compile, build, test, and run code for supported languages/tools.
- **Vim Utilities:** Source files, reload config, validate Vim script, open documentation.
- **Easy Customization:** Add or override menus and commands via your `.vimrc`.

---

## Installation (Vim & Neovim)

You can install vim-easyops in both Vim and Neovim using your favorite plugin manager or manually.

### Using [vim-plug](https://github.com/junegunn/vim-plug)

Add this to your `.vimrc` (Vim) or `init.vim`/`init.lua` (Neovim):

```vim
Plug 'josstei/vim-easyops'
```
Then start Vim/Neovim and run:
```
:PlugInstall
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim) (Neovim)

Add this to your `init.lua`:
```lua
use 'josstei/vim-easyops'
```
Then run:
```
:PackerSync
```

### Manual installation

Clone the repository using the official link:

For Vim:
```sh
git clone https://github.com/josstei/vim-easyops ~/.vim/pack/plugins/start/vim-easyops
```
For Neovim:
```sh
git clone https://github.com/josstei/vim-easyops ~/.config/nvim/pack/plugins/start/vim-easyops
```

---

## Usage

Open the EasyOps command menu at any time:

```
:EasyOps
```

Navigate with arrow keys or shortcuts to select categories and commands.

---

## Example: Mapping EasyOps to a Shortcut

To open EasyOps with a shortcut (for example, `<leader>m`), add this to your `.vimrc`:

```vim
nnoremap <silent> <leader>m :EasyOps<CR>
```

You can change `<leader>m` to any key sequence you like:

```vim
nnoremap <silent> <leader>e :EasyOps<CR>
```

You may also map it in other modes:

```vim
vnoremap <silent> <leader>m :EasyOps<CR>
onoremap <silent> <leader>m :EasyOps<CR>
```

---

## Customizing Menus in Your `.vimrc`

You can add, replace, or extend menus and commands by editing your `.vimrc`.

### 1. Add a Custom Python Menu

```vim
let g:easyops_commands_python = [
      \ { 'label': 'Python: Run', 'command': 'python3 ' . expand('%') },
      \ { 'label': 'Python: Format', 'command': 'black ' . expand('%') }
      \ ]
let g:easyops_menu_python = { 'commands': g:easyops_commands_python }
```

### 2. Add a Menu for Makefile Projects

```vim
let g:easyops_commands_make = [
      \ { 'label': 'Make: Build', 'command': 'make' },
      \ { 'label': 'Make: Clean', 'command': 'make clean' },
      \ { 'label': 'Make: Test', 'command': 'make test' }
      \ ]
let g:easyops_menu_make = { 'commands': g:easyops_commands_make }
```

### 3. Add Custom Menus to the Main Menu

```vim
if exists('g:easyops_commands_main')
  call add(g:easyops_commands_main, { 'label': 'Python', 'command': 'menu:python' })
  call add(g:easyops_commands_main, { 'label': 'Make', 'command': 'menu:make' })
endif
```

### 4. Override a Built-In Menu (e.g., Git)

```vim
let g:easyops_commands_git = [
      \ { 'label': 'Git: Status (Short)', 'command': 'git status -s' },
      \ { 'label': 'Git: Stash', 'command': 'git stash' }
      \ ]
let g:easyops_menu_git = { 'commands': g:easyops_commands_git }
```

**Tip:**  
Use `expand('%')` to refer to the current file in your custom commands.

---

## Preset Menus Available

These menus are available by default in vim-easyops. Each menu includes a set of context-aware commands for rapid access:

### Main Menu

- **Git:**  
  - Status, Pull, Push, Add All, Commit, Log, Fetch, Branches, Checkout
- **Window:**  
  - Window management commands
- **File:**  
  - Save, Quit, Force Quit
- **Code:**  
  - Language-specific actions based on filetype (Java, Rust, npm, Maven, Bundler, Vim, etc.)

### Git Menu

- `Git: Status`  
- `Git: Pull`  
- `Git: Push`  
- `Git: Add All`  
- `Git: Commit`  
- `Git: Log (Paged)`  
- `Git: Fetch`  
- `Git: Branches`  
- `Git: Checkout...`

### File Menu

- `File: Save`  
- `File: Quit`  
- `File: Force Quit`

### Code Menu (contextual, based on filetype)

- **Java:**  
  - Compile, Compile Project, Run
- **Maven:**  
  - Clean, Compile, Test, Package, Install, Verify, Deploy
- **Rust:**  
  - Compile, Run
- **npm:**  
  - Install, Build, Test, Start
- **Bundler:**  
  - Install, Update, Add Gem, Exec, List, Info, Outdated, Check, Init, Lock
- **Vim:**  
  - Source Current File, Reload Vim Config, Validate Syntax, Open Documentation

(*Menus for other languages and tools are automatically available if the project manifest is detected*)

## Works Great with [vim-easyenv](https://github.com/josstei/vim-easyenv)

Use vim-easyops alongside [vim-easyenv](https://github.com/josstei/vim-easyenv) for seamless environment management in Vim/Neovim. Quickly switch environments with vim-easyenv, then use vim-easyops’ unified menu to run project commands and version control—all without leaving your editor. Together, they streamline your workflow for maximum productivity.

---

## License

MIT License. See [LICENSE](LICENSE) for details.
