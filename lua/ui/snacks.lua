return {
  {
    "snacks.nvim",
    lazy = false,
    event = "DeferredUIEnter",
    after = function(plugin)
      local dashboardImage = "~/downloads/Netrunner-Jinteki.net-1-Intro-2667330870.jpg"
      require("snacks").setup({
        -- Only showing enabled tools.
        -- See https://github.com/folke/snacks.nvim?tab=readme-ov-file#-features
        -- for available tools
        -- FIXME: seriously consider the following:
        -- GitHub CLI integration
        -- gh = { enabled = true },
        -- Quick load
        -- quickfile = { enabled = true },

        -- prevent lsp attaching to big files. default is 1.5MB
        bigfile = { enabled = true },

        -- dashboard
        dashboard = {
          enabled = true,
          width = 60,
          row = nil,
          col = nil,
          pane_gap = 4,
          --NOTE: Use the actual binds instead of this shit.
          -- autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
          preset = {
            pick = nil,
            keys = {
              {
                icon = " ",
                desc = "New File",
                key = ":ene",
                action = ":ene | startinsert",
              },
              {
                icon = " ",
                desc = "Find File",
                key = "<leader>ff",
                action = ":Telescope find_files",
              },
              {
                icon = " ",
                desc = "Find Buffer",
                key = "<leader>fb",
                action = ":Telescope buffers",
              },
              {
                icon = " ",
                desc = "Live grep",
                key = "<leader>fg",
                action = ":Telescope live_grep",
              },
              {
                icon = " ",
                desc = "Recent Files",
                key = "<leader>fr",
                action = ":Telescope oldfiles",
              },
              {
                icon = "󰮥 ",
                desc = "Help tags",
                key = "<leader>fh",
                action = ":Telescope help_tags",
              },
            },

            header = [[
 _______ _     _ _______      _  _  _ _______ __   __       _____  _     _ _______
    |    |_____| |______      |  |  | |_____|   \_/        |     | |     |    |   
    |    |     | |______      |__|__| |     |    |         |_____| |_____|    |   
                                                                                  
      _____ _______      _______ _     _  ______  _____  _     _  ______ _     _  
        |   |______         |    |_____| |_____/ |     | |     | |  ____ |_____|  
      __|__ ______|         |    |     | |    \_ |_____| |_____| |_____| |     |  
                                                                                  ]],
          },
          formats = {
            icon = function(item)
              if item.file and item.icon == "file" or item.icon == "directory" then
                return Snacks.dashboard.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                  file = file:sub(-(ctx.width - #dir - 2))
                  fname = dir .. "/…" .. file
                end
              end
              local dir, file = fname:match("^(.*)/(.+)$")
              return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
            end,
          },
          sections = {
            {
              section = "terminal",
              cmd = ", chafa ~/src/nix/neovim/assets/jinteki.jpg --format symbols -s 50x50 --symbols ascii -c none; sleep .1",
              height = 35,
              width = 50,
              padding = 1,
            },
            {
              section = "header",
            },
            {
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            -- {
            --   icon = " ",
            --   title = "Git Status",
            --   section = "terminal",
            --   enabled = function()
            --     return Snacks.git.get_root() ~= nil
            --   end,
            --   cmd = "git --no-pager diff --stat -B -M -C",
            --   height = 5,
            --   padding = 1,
            --   ttl = 5 * 60,
            --   indent = 3,
            -- },
            {
              icon = " ",
              title = "Branches",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git branch --list",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
          },
        },
        -- Git
        git = { enabled = true },
        -- Gitbrowse
        gitbrowse = { enabled = true },

        -- picker/explorer
        -- FIXME: currently LPSs uses this but it may be worth replacing
        -- telescope with it as well
        picker = { enabled = true },
      })
    end,
  },
}
