# Neovim Config

## Structure

```
.config/nvim/
├── init.lua
├── lua
│   ├── completion.lua
│   ├── lsp
│   │   ├── clangd.lua
│   │   ├── mutt.lua
│   │   ├── pyright.lua
│   │   └── ruff.lua
│   ├── lsp.lua
│   ├── plugins
│   │   ├── copilot.lua
│   │   ├── gitsigns.lua
│   │   ├── heirline.lua
│   │   └── treesitter.lua
│   ├── plugins.lua
│   └── setup.lua
├── old_init.vim
└── README.md
```

#### init.lua

An overhead directory that loads other files using lua's `require()`

#### lua/setup.lua

The main file where key options are set for appearance, menus, interaction etc.

#### lua/plugins.lua and lua/plugins/<plugin_name>.lua

Plugins are managed via [vim-plug](https://github.com/junegunn/vim-plug) and all controlled from `lua/plugins.lua`.
This will install vim-plug if it is not already present, and then installs all of the plugins used.

The configurations for various different plugins are stored in their own files
under `lua/plugins/<plugin_name>.lua` and sourced in the main `init.lua`.

#### lua/completion.lua

Settings for [nvim-cpm](https://github.com/hrsh7th/nvim-cmp) plugin.
Completion and popup windows. Used in LSPs and other menus.

#### lua/lsp.lua and lua/lsp/<lsp_name>.lua

Language servers are set up in `lua/lsp.lua`.

Servers with longer configs are sourced from separate files
in `lua/lsp/`.

Note that each langauge server has to be installed separately from vim as a
separate dependency.

Currently used LSPs are:

- C and C++: [clangd](https://clangd.llvm.org/), usually installed via clang
- Python: pyright and ruff
- Rust: [rust-analyzer](https://rust-analyzer.github.io/)
- lua: lua-language-server

## LSP Commands quick reference

See mappings defined in `lua/completion.lua` and `lua/lsp.lua`.

Docs:

- `K` - view definition in popup
- `gd` - go to definition
- `gD` - go to declaration

Errors:

- `space q` - show summary of all warnings
- `space e` - open warning on current line
