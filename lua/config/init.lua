local ls = require "luasnip"

-- LSLS Part 2 / Two config settings for later

--require("luasnip").config.set_config({ -- Setting LuaSnip config
ls.config.set_config({ -- Setting LuaSnip config ...
  history = true,
  -- Enable autotriggered snippets
  enable_autosnippets = true,
  -- Use Tab to trigger visual selection
  store_selection_keys = "<Tab>",
})
-- See the LuaSnip README’s config section for full documentation of configuration options: https://github.com/L3MON4D3/LuaSnip#config

-- LSLS Part 2 / Set snippet trigger and tabstop navigation keys

-- Option one: use a single key (e.g. Tab) to both expand snippets and to jump forward through snippet tabstops.

vim.cmd[[
  " Use Tab to expand and jump through snippets
  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

  " Try using jk as your <Plug>luasnip-jump-next key, i.e. for jumping forward through tabstops: LSLS Part 2 / practical tips for fast editing
  'imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
  'smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next'

  " Then, set a backward-jump keymap:

  " Jump backward through snippet tabstops with Shift-Tab
  imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
  smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

  " Try jumping backward through snippet tabstops with 'kj'
  "imap <silent><expr> <kj> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<kj>'
  "smap <silent><expr> <kj> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<kj>'
]]

-- Finally, you may want to set mappings to cycle through choice nodes:

vim.cmd[[
  " Cycle forward through choice nodes with Control-f (for example)
  imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
  smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choic
]]
-- You can read about choice nodes at :help luasnip-choicenode
--Note: You need to apply tabstop navigation in both insert and visual modes, hence the use of both imap and smap for the forward and backward jump mappings. (Well, technically select mode and not visual mode, hence the use of smap and not vmap, but for a typical end user’s purposes select and visual mode look identical. See :help select-mode for details.)

-- LSLS Part 2 / Snippet files, directories, and loaders

-- This section explains where to store snippets on your file system, what file format to use, and how to make LuaSnip load the snippets for actual use.

-- LSLS Part 2 / Snippet format

--LuaSnip supports multiple snippet formats. Your first step is to decide which format you will write your snippets in. Your main options are:

-- Covered in this article: Native LuaSnip snippets written in Lua (support for all LuaSnip features, best integration with the larger Neovim ecosystem).

-- LuaSnip LaTeX Series Part 2 / Loading snippets and directory structure

-- You have two ways to load snippets:

-- #1 COVERED in THIS ARTICLE: write Lua snippets in dedicated snippet files and load these files using LuaSnip’s Lua loader feature.
-- #2 Define and load snippets in your Neovim startup files using LuaSnip’s add_snippets function.
-- This article covers #1, the Lua loader. I recommend this approach because using dedicated snippet files with the Lua loader decouples your snippets from your Neovim startup configuration.

-- LSLS Part 2 / Overview of how to load snippets from Lua files:

-- Write LuaSnip snippets in plain-text Lua files with the .lua extension.
-- Wrap all snippets in a given .lua file inside a Lua table, and return this table from the Lua file. (Examples follow.)
-- Name each snippet file appropriately: The file’s base name determines which Vim filetype the snippets apply to. For example, snippets inside the file tex.lua would apply to files with filetype=tex, snippets inside html.lua to files with filetype=html, and so on.

-- If you want certain snippets to apply globally to all file types, place these global snippets in the file all.lua. (This is the same naming scheme used by UltiSnips, in case you are migrating from UltiSnips).

-- Load snippets by calling the LuaSnip Lua loader’s load function from somewhere in your Neovim startup config (e.g. init.lua, init.vim, etc.):

-- Load all snippets from the nvim/LuaSnip directory at startup
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

-- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip"})

-- Bonus:  if you manually set the paths key when calling load or lazy_load, LuaSnip will not need to scan your entire Neovim runtimepath looking for luasnippets directories.

-- Want to use multiple snippet directories? No problem—set the paths key’s value to a table or comma-separated string of multiple directories. Here are two ways to load snippets from both the directory LuaSnip1 and LuaSnip2:

-- Two ways to load snippets from both LuaSnip1 and LuaSnip2.
-- 1. Using a table
--require("luasnip.loaders.from_lua").load({paths = {"~/.config/nvim/LuaSnip1/", "~/.config/nvim/LuaSnip2/"}})

-- 2. Using a comma-separated list
--require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip1/,~/.config/nvim/LuaSnip2/"})

-- Full syntax for the load call is documented in :help luasnip-loaders.
