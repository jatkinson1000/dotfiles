local conditions = require("heirline.conditions")
local utils = require("heirline.utils")


-- SET COLOURS --
-- local colors = require'kanagawa.colors'.setup()    -- Set from scheme
local colors = {                                   -- Get from local scheme
--     -- Names as appear in kanagawa scheme
--     bright_bg = utils.get_highlight("Folded").bg,
--     bright_fg = utils.get_highlight("Folded").fg,
--     red = utils.get_highlight("DiagnosticError").fg,
--     dark_red = utils.get_highlight("DiffDelete").bg,
--     green = utils.get_highlight("String").fg,
--     blue = utils.get_highlight("Function").fg,
--     gray = utils.get_highlight("NonText").fg,
--     orange = utils.get_highlight("Constant").fg,
--     purple = utils.get_highlight("Statement").fg,
--     cyan = utils.get_highlight("Special").fg,
--     diag_warn = utils.get_highlight("DiagnosticWarn").fg,
--     diag_error = utils.get_highlight("DiagnosticError").fg,
--     diag_hint = utils.get_highlight("DiagnosticHint").fg,
--     diag_info = utils.get_highlight("DiagnosticInfo").fg,
--     git_del = utils.get_highlight("diffDeleted").fg,
--     git_add = utils.get_highlight("diffAdded").fg,
--     git_change = utils.get_highlight("diffChanged").fg,

    -- Names as appear in Carbonfox scheme
    red = utils.get_highlight("Error").fg,
    dark_red = utils.get_highlight("builtin0").fg,
    blue = utils.get_highlight("Func").fg,
    orange = utils.get_highlight("Const").fg,
    cyan = utils.get_highlight("Ident").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
    git_del = utils.get_highlight("diffRemoved").fg,
}
require("heirline").load_colors(colors)


-- TRIVIAL SPACING COMPONENTS --
local Align = { provider = "%=" }
local Space = { provider = " " }
-- Other spacing info/crash course:
-- %4l        -- Defines item %l to always be minimum width 4 but can grow larger
-- %5(.....%) -- defines a group that is minimum width 5 but can grow larger


-- CURSOR POSITION
local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %p = percentage through file of displayed window as number
    -- %P = percentage through file of displayed window as Top, n%, Bot
    provider = "[%l:%c %p%%]",
}


--  FILENAME --
local FileNameBlock = {
    -- let's first set up some attributes needed by this component and its children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

-- Show if files is modified and unsaved, or readonly
local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " [+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
    },
}

-- Set up a "modifier" to change the colour of the filename if it is modified
local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force=true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)

-- Search Results
-- Gives the search term and number.
-- NB this information already appears in the command line when searching, but using
-- this will persist this information in the status line.
-- From https://github.com/rebelot/heirline.nvim/wiki/Exotic-recipes#search-results
local SearchResults = {
    condition = function(self)
        local lines = vim.api.nvim_buf_line_count(0)
        if lines > 50000 then return end

        local query = vim.fn.getreg("/")
        if query == "" then return end

        if query:find("@") then return end

        local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
        local active = false
        if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
            active = true
        end
        if not active then return end

        query = query:gsub([[^\V]], "")
        query = query:gsub([[\<]], ""):gsub([[\>]], "")

        self.query = query
        self.count = search_count
        return true
    end,
    {
        provider = function(self)
            return table.concat({
                ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
            })
        end,
        hl = nil -- your highlight goes here
    },
    Space -- A separator after, if section is active, without highlight.
}


-- GIT --
local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = "orange" },


    {   -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = { fg = "git_add" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = "git_del" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = { fg = "git_change" },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },
}


-- BUILD STATUSLINE FROM COMPONENTS
local StatusLine = {Git, Space, FileNameBlock, Align, Ruler}

local WinBar = {{}, {}}

local TabLine = {{}, {}}

-- the winbar parameter is optional!
require("heirline").setup({
    statusline = StatusLine,
    -- winbar = WinBar,
    -- tabline = TabLine,
    -- statuscolumn = StatusColumn
    -- opts = {...} -- other config parameters, see below
})
