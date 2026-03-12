-- Two important keymaps to use while in telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

local telescope_ignore_patterns = {
  -- Ignore nix lock files
  "%.lock",
}

-- Allows you to toggle the search to include hidden files
-- From https://github.com/nvim-telescope/telescope.nvim/issues/2874#issuecomment-1900967890
local function custom_find_files(opts, no_ignore)
  opts = opts or {}
  no_ignore = vim.F.if_nil(no_ignore, false)
  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(prompt_bufnr)
      no_ignore = not no_ignore
      custom_find_files({ default_text = prompt }, no_ignore)
    end)
    return true
  end

  if no_ignore then
    opts.no_ignore = true
    opts.hidden = true
    opts.prompt_title = "Find Files <ALL>"
    require("telescope.builtin").find_files(opts)
  else
    opts.prompt_title = "Find Files"
    require("telescope.builtin").find_files(opts)
  end
end

return {
  {
    "telescope.nvim",
    category = "search",
    cmd = { "Telescope", "LiveGrepGitRoot" },
    on_require = { "telescope" },
    -- stylua: ignore start
    keys = {
      {
        "<leader>/",
        function()
          -- Slightly advanced example of overriding default behavior and theme
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        mode = { "n" },
        desc = '[/] Fuzzily search in current buffer',
      },
      {
        "<leader>f/",
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        mode = { "n" },
        desc = '[F]ind [/] in Open Files'
      },
      { "<leader>fp", live_grep_git_root,                   mode = { "n" }, desc = "[F]ind in git [P]roject root" },
      -- File pickers
      { "<leader>ff", custom_find_files,                       mode = { "n" }, desc = "[F]ind [F]iles" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",         mode = { "n" }, desc = "[F]ind in [B]uffers" },
      { "<leader>f.", "<cmd>Telescope oldfiles<cr>",        mode = { "n" }, desc = "[F]ind in recent files ('.' for repeat)" },
      { "<leader>fr", "<cmd>Telescope resume<cr>",          mode = { "n" }, desc = "[F]ind [R]esume" },

      -- Search
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",       mode = { "n" }, desc = "[F]ind by [G]rep" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>",     mode = { "n" }, desc = "[F]ind [W]ord under cursor" },

      -- Misc
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",       mode = { "n" }, desc = "[F]ind [H]elp tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",         mode = { "n" }, desc = "[F]ind [K]eymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>",        mode = { "n" }, desc = "[F]ind [C]ommands" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>",        mode = { "n" }, desc = "[F]ind [Q]uickfix" },
      { "<leader>f:", "<cmd>Telescope command_history<cr>", mode = { "n" }, desc = "[F]ind [:]command history" },

      -- Diagnostics
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",     mode = { "n" }, desc = "Diagnostics" },
    },
    -- stylua: ignore end
    after = function(plugin)
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          -- path_display = { "truncate" },
          -- sorting_strategy = "ascending",
          file_ignore_patterns = telescope_ignore_patterns,
          layout_strategy = "flex", -- Change layout depending on if on laptop screen or dualup
          layout_config = {
            flex = {
              flip_columns = 180,
              flip_lines = 50,
            },
            vertical = {
              preview_height = 0.75,
              height = 0.95,
            },
          },
        },
        pickers = {
          -- FIXME: confirm if these needed?
          -- find_files = {
          --   theme = "dropdown",
          --   previewer = true,
          -- },
          -- git_files = {
          --   theme = "dropdown",
          --   previewer = true,
          -- },
          -- buffers = {
          --   theme = "dropdown",
          --   previewer = true,
          --   initial_mode = "normal",
          -- },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
    end,
  },
  {
    "telescope-fzf-native.nvim",
    dep_of = { "telescope.nvim" },
  },
  {
    "telescope-ui-select.nvim",
    dep_of = { "telescope.nvim" },
  },
}
