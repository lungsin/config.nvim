return {
  'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  config = function ()
    vim.key.map("n", "<leader>ts", "<cmd>Sleuth<cr>", {desc = "Trigger sleuth: adjust indent width"})
  end
}
