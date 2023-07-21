-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- GENERAL
require "config.init"
require "config.options"
require "config.keymaps"
require "config.plugins"
require "config.autocommands"
require "config.colorscheme"

-- PLUGINS
require "config.autopairs"
require "config.comment"
require "config.impatient"
require "config.surround"
require "config.yanky"
require "config.undotree"

-- Mappings
require "config.whichkey"
require "config.better-escape"
-- Terminal
require "config.toggleterm"

-- File Management
require "config.neo-tree"
require "config.sessions"
require "config.LeaderF"

-- Appearance
require "config.bufferline"
require "config.lualine"
require "config.indentline"
require "config.alpha"
--require "config.dashboard-nvim"
require "config.illuminate"

-- Autocomplete
require "config.cmp"

-- LaTeX
require "config.vimtex"

-- Markdown
require "config.autolist"

-- Snippets
require "config.luasnip"

-- Telescope
require "config.telescope"
require "config.dressing"
require "config.telescope-fzf"

-- Treesitter
require "config.treesitter"

-- Git
require "config.gitsigns"