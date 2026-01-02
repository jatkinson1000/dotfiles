# Neovim Config

## Dependencies

- `treesitter` and `treesitter-cli`
- A Nerd Font
- Various lsp clients as desired

## Structure

```
.config/nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── globals.lua
│   │   ├── opts.lua
│   │   ├── keymaps.lua
│   │   ├── filetypes.lua
│   │   ├── autocommands.lua
│   │   ├── lazy.lua
│   │   └── lsp.lua
│   ├── utils.lua
│   ├── plugins/
│   │   ├── colour.lua
│   │   └── <plugin_name>.lua
│   └── lsp/
│       └── <lsp_client>.lua
└── README.md
```

#### init.lua

An overhead directory that loads other files (modules) using lua's `require()`

#### utils.lua

A library of lua utilities to be used elsewhere in the setup.

#### lua/core/

Modules for core functionality

- `globals.lua` - Set any global variables.
- `opts.lua` - Set options for appearance, menus, interaction etc.
- `keymaps.lua` - define any keymaps.
- `filetypes.lua` - add any custom filetypes used.
- `autocommands.lua` - Set up any autocommands.
- `lazy.lua` - config and setup for lazy.nvim plugin manager.
- `lsp.lua` - config and setup for language servers. Includes loading servers, and
  diagnostics settings.

#### lua/plugins/

Plugins are managed via [lazy.nvim](https://lazy.folke.io) and controlled from
`core/lazy.lua`.
This will install lazy.nvim if it is not already present, and then installs all of the
plugins used.

The configurations for various different plugins are stored in their own specification
files under `lua/plugins/<plugin_name>.lua` as described in the documentation.

Colourschemes are managed under a single specification file `colour.lua`,

#### lua/lsp/<lsp_client>.lua

Language servers are set up in `lua/code/lsp.lua`.

Servers with longer configs are sourced from separate files
in `lua/lsp/<lsp_client>`.

Note that each langauge server has to be installed separately from vim as a
dependency.

Currently used LSPs are:

- C and C++: [clangd](https://clangd.llvm.org/), usually installed via clang
- Python: pyright and ruff
- Rust: [rust-analyzer](https://rust-analyzer.github.io/)
- lua: lua-language-server
