return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    -- Folding options
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- large value for ufo
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Keymaps
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zK", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end, { desc = "Peek Fold" })

    require("ufo").setup()
  end,
}
