local globals = {
  mapleader = " ",
  maplocalleader = "\\",
}

for key, val in pairs(globals) do
  vim.g[key] = val
end
