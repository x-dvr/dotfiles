vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }

require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = true, -- disables setting the background color.
    float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
    },
    highlight_overrides = {
        latte = function(latte)
            return {
                Normal = { fg = latte.base },
            }
        end,
        frappe = function(frappe)
            return {
                ["@comment"] = { fg = frappe.surface2, style = { "italic" } },
                LineNr = { fg = frappe.surface2 },
                -- Comment = { fg = mocha.flamingo },
            }
        end,
    },
    integrations = {
        fzf = true,
    }
})
-- setup must be called before loading
vim.cmd.colorscheme "catppuccin-nvim"