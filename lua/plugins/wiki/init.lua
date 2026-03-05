--FIXME: verify binds and paths here
return {
  {
    "vimwiki",
    event = "DeferredUIEnter",
    after = function(name)
      -- See :h vimwiki_list for info on registering wiki paths
      local wiki_0 = {
        path = '~/sync/obsidian-vault-01/wiki/',
        index = 'abbot-wiki/ta-wiki/_TA-TASKS',
        syntax = 'markdown',
        ext = '.md',

        -- fill spaces in page names with _ in pathing
        links_space_char = '_'
      }
      local wiki_1 = {
        path = '~/src/abbot-wiki/',
        index = '0_home',
        syntax = 'markdown',
        ext = '.md',
        links_space_char = '_'
      }
      vim.g.vimwiki_list = { wiki_0, wiki_1 }
      -- vim.g.vimwiki_list = { wiki_0, wiki_1, wiki_2 }
  end
  },
}
