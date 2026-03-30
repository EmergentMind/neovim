return {
  {
    'flash.nvim',
    auto_enable = true,
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
    after = function(name)
      require('flash').setup({
        labels = 'asdfghjklqwertyuiopzxcvbnm',
        search = {
          multi_window = true,
          forward = true,
          wrap = true,
          mode = 'exact',
          incremental = false,
        },
        jump = {
          jumplist = true,
          pos = 'start',
          history = false,
          register = false,
          nohlsearch = false,
          autojump = false,
        },
        label = {
          uppercase = true,
          rainbow = {
            enabled = true,
            shade = 5,
          },
        },
        modes = {
          search = {
            enabled = true,
          },
          char = {
            enabled = true,
            keys = { 'f', 'F', 't', 'T', ';', ',' },
            jump_labels = true,
          },
        },
      })
    end,
  },
}
