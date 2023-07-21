-- better-escape.nvim
-- https://reposhub.com/python/full-stack-web-frameworks/max397574-better-escape-nvim.html

local status_ok, betterescape = pcall(require, "better-escape")
if not status_ok then
  return
end

-- lua, default settings
require("better-escape").setup {
    mapping = {"jk", "jj"}, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in ms within which the keys must be hit. Use option timeoutlen by default
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    -- example
    keys = function()
      return vim.fn.col '.' - 2 >= 1 and '<esc>l' or '<esc>'
    end,
}
