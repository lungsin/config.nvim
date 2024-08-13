-- Fuzzy Finder (files, lsp, etc)
return {
    "ibhagwan/fzf-lua",
    event = 'VimEnter',
    enabled = vim.g.picker == "fzf-lua",
    dependencies = {
        -- Useful for getting pretty icons, but requires a Nerd Font.
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
}
