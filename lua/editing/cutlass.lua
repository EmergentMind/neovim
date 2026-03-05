return {
{
    "vim-cutlass",
    event = "DeferredUIEnter",
    keys = {
      { "x",  "d",  mode = { "n", "x" }, noremap = true, desc = "cut text to clipboard" },
      { "dd", mode = { "n" },      noremap = true, desc = "cut line to clipboard" },
      { "X",  "D",  mode = { "n" },      noremap = true, desc = "cut remaining line to clipboard" },
    },
  },
}
