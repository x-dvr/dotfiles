vim.pack.add {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/ibhagwan/fzf-lua",
}

require("lualine").setup()

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
    winopts = { backdrop = 85 },
})