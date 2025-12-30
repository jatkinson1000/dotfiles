# Neovim Config

## Structure

```
.config/nvim/
├── init.lua
├── lua
│   ├── core
│   │   ├── globals.lua
│   │   ├── opts.lua
│   │   ├── keymaps.lua
│   │   └── lazy.lua
│   ├── utils.lua
│   └── plugins
│       └── colour.lua
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
- `lazy.lua` - config and setup for lazy.nvim plugin manager.

#### lua/plugins/

Plugins are managed via [lazy.nvim](https://lazy.folke.io) and controlled from
`core/lazy.lua`.
This will install lazy.nvim if it is not already present, and then installs all of the
plugins used.

The configurations for various different plugins are stored in their own specification
files under `lua/plugins/<plugin_name>.lua` as described in the documentation.

Colourschemes are managed under a single specification file `colour.lua`,
