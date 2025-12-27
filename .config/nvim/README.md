# Neovim Config

## Structure

```
.config/nvim/
├── init.lua
├── lua
│   └── core
│       ├── globals.lua
│       ├── opts.lua
│       └── keymaps.lua
└── README.md
```

#### init.lua

An overhead directory that loads other files (modules) using lua's `require()`

#### lua/core

Modules for core functionality

- `globals.lua` - Set any global variables.
- `opts.lua` - Set options for appearance, menus, interaction etc.
- `keymaps.lua` - define any keymaps.
