return {
  {
    'which-key.nvim',
    event = 'DeferredUIEnter',
    after = function(name)
      require('which-key').setup({
        preset = 'modern',
        delay = 150,
        icons = {
          mappings = true,
          keys = {},
        },
        spec = {
          { '<leader>a', group = '[a]i' },
          { '<leader>b', group = '[b]uffer' },
          { '<leader>d', group = '[d]ebugger' },
          { '<leader>e', group = 'neotree [e]xplorer' },
          { '<leader>f', group = '[f]ind with telescope' },
          { '<leader>F', group = '[F]ormatting' },
          { '<leader>g', group = '[g]it' },
          { '<leader>i', group = '[i]nverse value' },
          { '<leader>l', group = '[l]sp' },
          { '<leader>m', group = '[m]arkdown' },
          { '<leader>o', group = '[o]bsidian' },
          { '<leader>s', group = '[s]earch/replace' },
          -- FIXME: does this collide with above?
          -- { '<leader>s', group = '[s]ession' },
          { '<leader>t', group = '[t]oggle settings' },
          { '<leader>u', group = '[u]ndotree' },
          { '<leader>w', group = '[w]iki and window motions' },
          { '<leader>x', group = 'quickfi[x] & diagnostics' },
          { '<leader>y', group = '[y]ank' },
          { '<leader>z', group = '[z]en' },
          { '<leader><leader>', group = 'misc' },
        },
      })
    end,
  },
}
