local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")

conf = {}
conf.header = {
  "                                                       ",
  "                                                       ",
  "                                                       ",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "                                                       ",
  "                                                       ",
  "                                                       ",
  "                                                       ",
}

conf.center = {
  {
    icon = "  ",
    desc = "Sessions                              ",
    action = "<cmd>SessionManager load_session<CR>",
    key = "s",
  },
  {
    icon = "  ",
    desc = "Find  File                            ",
    --action = ":Telescope find_files<CR>",
    action = "Leaderf file --popup",
    key = "<Leader> f f",
  },
  {
    icon = "  ",
    desc = "Recently opened files                 ",
    --action = ":Telescope oldfiles<CR>",
    action = "Leaderf mru --popup",
    key = "<Leader> f r",
  },
  --{
    --icon = "  ",
    --desc = "Project grep                            ",
    --action = "Leaderf rg --popup",
    --key = "<Leader> f g",
  --},
  {
    icon = "  ",
    desc = "Cfg-Info                               ",
    action = "<cmd>e ~/.config/CheatSheet.md<cr>   ",
    key = "i",
  },
  {
    icon = "  ",
    desc = "New file                              ",
    action = "enew",
    key = "e",
  },
  {
    icon = "  ",
    desc = "Quit Nvim                             ",
    action = "qa",
    key = "q",
  },
}

--dashboard.setup({
  --theme = 'doom',
  --shortcut_type = 'number',
  --config = conf
--})

dashboard.setup({
  theme = 'doom',
  config = {
    header = {[[                                                    ]],
 [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
 [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
 [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
 [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
 [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
 [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
 [[                                                    ]],}, --your header
    center = {
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Find File           ',
        desc_hl = 'String',
        key = 'b',
        keymap = 'SPC f f',
        --" Search files in popup window
        -- nnoremap <silent> <leader>ff :<C-U>Leaderf file --popup<CR>
        key_hl = 'Number',
        action = 'lua print(2)'
      },
      {
        icon = ' ',
        desc = 'Find Dotfiles',
        key = 'f',
        keymap = 'SPC f d',
        action = 'lua print(3)'
      },
    },
    footer = {}  --your footer
  }
})

api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function ()
    keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
  end
})
