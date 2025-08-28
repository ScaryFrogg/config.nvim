return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    require("git-conflict").setup {
      default_mappings = {
        ours = "<leader>o",
        theirs = "<leader>t",
        none = "<leader>0",
        both = "<leader>b",
        next = "<leader>n",
        prev = "<leader>p",
      },
    }
  end,
}
