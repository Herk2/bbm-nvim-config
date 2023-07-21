local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Packer
return packer.startup(function(use)
  -- Have packer manage itself
  use { "wbthomason/packer.nvim" }
  -- Useful lua functions used by lots of plugins
  use { "nvim-lua/plenary.nvim" }

-- General
  use { "windwp/nvim-autopairs" }
  use { "numToStr/Comment.nvim" }
  use { "lewis6991/impatient.nvim" }
  use { "kylechui/nvim-surround" }
  use { "mbbill/undotree" } -- Vimscript
  use { "glacambre/firenvim" } -- Vimscript
  use { "gbprod/yanky.nvim" }

-- Mappings
	use { "folke/which-key.nvim" }
  use {
  "max397574/better-escape.nvim",
  config = function()
    require("better-escape").setup()
  end,
}

-- Terminal
  use { "akinsho/toggleterm.nvim" }

-- File Management
  --use { "nvim-tree/nvim-tree.lua" }
  --use { "nvim-tree/nvim-web-devicons" }
	use { "Shatur/neovim-session-manager" }
  -- File search, tag search and more
  use { "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" }


  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
  }

-- Appearance
  use { "akinsho/bufferline.nvim" }
  use { "nvim-lualine/lualine.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }
  --use {
    --"glepnir/dashboard-nvim",
    --event = "VimEnter",
    --config = function()
      --require('dashboard').setup {
      -- config
    --}
    --end,
    --requires = {'nvim-tree/nvim-web-devicons'}
  --}
  -- fancy start screen
  --use { "nvimdev/dashboard-nvim", event = "VimEnter",
    --cond = firenvim_not_active,
    --config = [[require('user.dashboard-nvim')]]
    --config = [[require('nvim-tree/nvim-web-devicons')]]
  --}

  use { "RRethy/vim-illuminate" }

-- Colorschemes
  --use { "ellisonleao/gruvbox.nvim" }
  -- use { "luisiacc/gruvbox-baby" }
  use { "folke/tokyonight.nvim" }
  -- use { "lunarvim/darkplus.nvim" }
  -- use { "navarasu/onedark.nvim" }
  -- use { "savq/melange" }
  -- use { "EdenEast/nightfox.nvim" }
  -- use { "navarasu/onedark.nvim" }

-- CMP
  use { "hrsh7th/nvim-cmp" }
	use { "hrsh7th/cmp-nvim-lsp" }
  -- buffer completions
  use { "hrsh7th/cmp-buffer" }
  -- path completions
  use { "hrsh7th/cmp-path" }
  -- snippet completions
	use { "saadparwaiz1/cmp_luasnip" }
  -- command completions
  use { "hrsh7th/cmp-cmdline" }
  -- spelling completions
  use { "f3fora/cmp-spell" }
  -- helps Vimtex completions
  use { "hrsh7th/cmp-omni" }
  -- use { "aspeddro/cmp-pandoc.nvim" }

-- LSP
  -- enable LSP
	use { "neovim/nvim-lspconfig" }
  -- simple to use language server installer
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  -- for formatters and linters
	use { "jose-elias-alvarez/null-ls.nvim" }

-- LaTeX
  use { "lervag/vimtex" } -- essential for LaTeX; Vimscript
  use { "kdheepak/cmp-latex-symbols" }
  use { "jbyuki/nabla.nvim" } -- show symbols in editor

-- Markdown
  use({
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
      "norg",
    },
    config = function()
      require("autolist").setup()

      -- vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      -- vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")

      -- cycle list types with dot-repeat
      -- vim.keymap.set("n", "<leader>ln", require("autolist").cycle_next_dr, { expr = true })
      -- vim.keymap.set("n", "<leader>lp", require("autolist").cycle_prev_dr, { expr = true })

      -- functions to recalculate list on edit
      vim.keymap.set("n", "<tab>", "><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<s-tab>", "<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  })

-- Snippets
  --snippet engine
  --use { "L3MON4D3/LuaSnip" }
  use({
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  tag = "v1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!:).
  run = "make install_jsregexp"
})
--use { --sbulav.github.io
--    'L3MON4D3/LuaSnip',
--    after = 'nvim-cmp',
--    config = function() require('config.snippets') end,
--}
  -- a bunch of snippets to use
  -- use { "garbas/vim-snipmate" }
  -- use { "rafamadriz/friendly-snippets" }

-- Telescope
	use { "nvim-telescope/telescope.nvim" }
    -- , commit = "76ea9a898d3307244dce3573392dcf2cc38f340f"
	use { "stevearc/dressing.nvim" }
  use { "nvim-telescope/telescope-bibtex.nvim",
    config = function ()
      --require"telescope".load_extension("bibtex")
      require('telescope').load_extension('fzf')
    end,
  }

  -- Telescope-fzf - ( telescope-nvim/telescope-fzf-native.nvim )
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'arch -arm64 gmake' }
  --use {'nvim-telescope/telescope-fzf-native.nvim', run : '-target arm64-apple-macos12 make' }
  --use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

-- Treesitter
	use { "nvim-treesitter/nvim-treesitter" }
-- , commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac"

-- Git
	use { "lewis6991/gitsigns.nvim" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
