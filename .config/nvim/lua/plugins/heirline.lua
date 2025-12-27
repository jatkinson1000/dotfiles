return {
  "rebelot/heirline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"  -- Get icons in neovim.
  },
  config = function()
    -- Construct components and assemble bar to return
    -- Basic process is as follows:
       -- Import/define globally useful things
       -- Assemble individual components
       -- Combine components to make statuslines
       -- Return via setup

    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    -- Spacing components
    -- %5(...%) -- group of minimum width 5 but can grow larger
    local Space = { provider = " " }   -- A single space
    local Align = { provider = "%=" }  -- Like hfill

    -- Colours
    local colors = {
        -- Names as appear in Carbonfox scheme
        red = utils.get_highlight("Error").fg,
        dark_red = utils.get_highlight("builtin0").fg,
        blue = utils.get_highlight("Func").fg,
        orange = utils.get_highlight("Const").fg,
        cyan = utils.get_highlight("Ident").fg,
        purple = utils.get_highlight("Statement").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
        git_del = utils.get_highlight("diffRemoved").fg,
        directory = utils.get_highlight("Directory").fg,
    }
    require("heirline").load_colors(colors)

    -- =====================================================
    -- Define individual components
    -- =====================================================
    -- Ruler showing position in the file
    local Ruler = {
        -- %l = current line number
        -- %L = number of lines in the buffer
        -- %c = column number
        -- %p = percentage through file of displayed window as number
        -- %P = percentage through file of displayed window as Top, n%, Bot
        provider = "[%l:%c %p%%]",
    }

    -- -----------------------------------------------------
    -- FilenameBlock showing the open filename
    -- Includes an icon from nvim-web-devicons, filename, and status of the file
    local FileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
    }

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
            -- trim the pattern relative to the current directory. For other options, see :h filename-modifers
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then return "[No Name]" end
            -- now, if the filename would occupy more than 1/4 of the available space trim the file path to its initials
            if not conditions.width_percent_below(#filename, 0.25) then
                filename = vim.fn.pathshorten(filename)
            end
            return filename
        end,
        hl = { fg = "directory" },
    }

    -- Show if file is modified and unsaved, or readonly
    local FileFlags = {
        {
            condition = function()
                return vim.bo.modified
            end,
            provider = " [+]",
            hl = { fg = "green", bold = true },
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

    -- Add the children to FileNameBlock component
    FileNameBlock = utils.insert(FileNameBlock,
        FileIcon,
        utils.insert(FileNameModifer, FileName), -- new table where FileName is a child of FileNameModifier
        FileFlags,
        { provider = '%<'} -- cut statusline here when there's not enough space
    )

    -- -----------------------------------------------------
    -- VI Mode
    local ViMode = {
        -- get vim current mode
        -- compute only once per component evaluation and store as a component attribute
        init = function(self)
            self.mode = vim.fn.mode(1) -- :h mode()
        end,

        -- Dictionaries to map the output of mode() to a string and color.
        -- We can put these into `static` to compute them at initialisation time.
        static = {
            mode_names = { -- Mapping for strings to display for each mode
                n = "N ",
                no = "N?",
                nov = "N?",
                noV = "N?",
                ["no\22"] = "N?",
                niI = "Ni",
                niR = "Nr",
                niV = "Nv",
                nt = "Nt",
                v = "V ",
                vs = "Vs",
                V = "V_",
                Vs = "Vs",
                ["\22"] = "^V",
                ["\22s"] = "^V",
                s = "S ",
                S = "S_",
                ["\19"] = "^S",
                i = "I ",
                ic = "Ic",
                ix = "Ix",
                R = "R ",
                Rc = "Rc",
                Rx = "Rx",
                Rv = "Rv",
                Rvc = "Rv",
                Rvx = "Rv",
                c = "C ",
                cv = "Ex",
                r = "...",
                rm = "M ",
                ["r?"] = "? ",
                ["!"] = "! ",
                t = "T ",
            },
            mode_colors = {
                n = "purple" ,
                i = "green",
                v = "cyan",
                V =  "cyan",
                ["\22"] =  "cyan",
                c =  "orange",
                s =  "purple",
                S =  "purple",
                ["\19"] =  "purple",
                R =  "orange",
                r =  "orange",
                ["!"] =  "red",
                t =  "red",
            }
        },
        -- We can now access the value of mode() that, by now, would have been
        -- computed by `init()` and use it to index our strings dictionary.
        -- note how `static` fields become just regular attributes once the
        -- component is instantiated.
        -- To be extra meticulous, we can also add some vim statusline syntax to
        -- control the padding and make sure our string is always at least 2
        -- characters long. Plus a nice Icon.
        provider = function(self)
            return " %2("..self.mode_names[self.mode].."%)"
        end,
        -- Same goes for the highlight. Now the foreground will change according to the current mode.
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, }
        end,
        -- Re-evaluate the component only on ModeChanged event!
        -- Also allows the statusline to be re-evaluated when entering operator-pending mode
        update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function()
                vim.cmd("redrawstatus")
            end),
        },
    }

    -- -----------------------------------------------------
    -- Search results
    -- Show the search term and number of matches.
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

    -- -----------------------------------------------------
    -- Git info
    local Git = {
      condition = conditions.is_git_repo, -- Show only if in a Git repo
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,

      hl = { fg = "orange" },

      -- Set up status report with following format:
      -- branch_name(+add-del~change)
      {
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

    -- -----------------------------------------------------
    -- Tab line
    -- -----------------------------------------------------
    -- Provide the buffer number
    local TablineBufnr = {
        provider = function(self)
            return tostring(self.bufnr) .. ". "
        end,
        hl = "black",
    }

    -- Provide the buffer filename
    local TablineFileName = {
        provider = function(self)
            local filename = self.filename
            filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
            return filename
        end,
        hl = function(self)
            return { bold = self.is_active or self.is_visible, italic = true }
        end,
    }

    -- Indicate file status
    local TablineFileFlags = {
        {
            condition = function(self)
                return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
            end,
            provider = " [+]",
            hl = { fg = "black" },
        },
        {
            condition = function(self)
                return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
                    or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
            end,
            provider = function(self)
                if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
                    return "  "
                else
                    return ""
                end
            end,
            hl = { fg = "orange" },
        },
    }

    -- Assemble a buffer header title from above components
    local TablineFileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
            if self.is_active then
                return "TabLineSel"
            elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
                return { fg = "gray" }
            else
                return "TabLine"
            end
        end,
        on_click = {
            callback = function(_, minwid, _, button)
                if (button == "m") then -- close on mouse middle click
                    vim.schedule(function()
                        vim.api.nvim_buf_delete(minwid, { force = false })
                    end)
                else
                    vim.api.nvim_win_set_buf(0, minwid)
                end
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = "heirline_tabline_buffer_callback",
        },
        TablineBufnr,
        FileIcon, -- reuse component from status line
        TablineFileName,
        TablineFileFlags,
    }

    -- Prettify TablineFilenameBlock headers
    local TablineBufferBlock = utils.surround({ "", "" }, function(self)
        if self.is_active then
            return utils.get_highlight("TabLineSel").bg
        else
            return utils.get_highlight("TabLine").bg
        end
    end, { TablineFileNameBlock })

    -- Default function used to retrieve buffers.
    -- Create a TablineBufferBlock for each.
    local get_bufs = function()
        return vim.tbl_filter(function(bufnr)
            return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
        end, vim.api.nvim_list_bufs())
    end
    -- initialize the buflist cache
    local buflist_cache = {}
    local BufferLine = utils.make_buflist(
        TablineBufferBlock,
        { provider = " ", hl = { fg = "gray" } },
        { provider = " ", hl = { fg = "gray" } },
        -- out buf_func simply returns the buflist_cache
        function()
            return buflist_cache
        end,
        -- no cache, as we're handling everything ourselves
        false
    )

    -- -----------------------------------------------------
    -- Create an indicvation of open tabs as well as buffers
    local Tabpage = {
        provider = function(self)
            return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
        end,
        hl = function(self)
            if not self.is_active then
                return "TabLine"
            else
                return "TabLineSel"
            end
        end,
    }

    local TabpageClose = {
        provider = "%999X 󰯆 %X",
        hl = "TabLine",
    }

    local TabPages = {
        -- only show this component if there's 2 or more tabpages
        condition = function()
            return #vim.api.nvim_list_tabpages() >= 2
        end,
        { provider = "%=" },
        utils.make_tablist(Tabpage),
        TabpageClose,
    }

    -- Define an offset for if a sidebar is open
    local TabLineOffset = {
        condition = function(self)
            local win = vim.api.nvim_tabpage_list_wins(0)[1]
            local bufnr = vim.api.nvim_win_get_buf(win)
            self.winid = win

            if vim.bo[bufnr].filetype == "NvimTree" then
                self.title = "NvimTree"
                return true
            -- elseif vim.bo[bufnr].filetype == "TagBar" then
            --     ...
            end
        end,

        provider = function(self)
            local title = self.title
            local width = vim.api.nvim_win_get_width(self.winid)
            local pad = math.ceil((width - #title) / 2)
            return string.rep(" ", pad) .. title .. string.rep(" ", pad)
        end,

        hl = function(self)
            if vim.api.nvim_get_current_win() == self.winid then
                return "TablineSel"
            else
                return "Tabline"
            end
        end,
    }

    -- =====================================================
    -- Assemble final lines from above components
    -- =====================================================
    local StatusLine = {ViMode, Space, Git, Space, FileNameBlock, Space, SearchResults, Align, Ruler}
    local TabLine = { TabLineOffset, BufferLine, TabPages }

    -- =====================================================
    -- Call setup
    -- =====================================================
    require("heirline").setup({
      statusline = StatusLine,
      tabline = TabLine,
    })

    -- =====================================================
    -- Set further options an autocommands for when loaded
    -- =====================================================
    vim.opt.showtabline=2  -- Always show the tabline (0 never, 1 >=2, 2 always)

    -- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
    vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
        callback = function()
            vim.schedule(function()
                local buffers = get_bufs()
                for i, v in ipairs(buffers) do
                    buflist_cache[i] = v
                end
                for i = #buffers + 1, #buflist_cache do
                    buflist_cache[i] = nil
                end

                -- check how many buffers we have and set showtabline accordingly
                if #buflist_cache > 1 then
                    vim.o.showtabline = 2 -- always
                elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
                    vim.o.showtabline = 1 -- only when #tabpages > 1
                end
            end)
        end,
    })

  end  -- End config function
}
