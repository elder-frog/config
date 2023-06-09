--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- imports

-- vim options
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.completeopt = "menu,menuone,noinsert"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
    pattern = "*",
    timeout = 5000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"               -- "Save"
lvim.keys.normal_mode["<C-y>"] = ": %w !pbcopy<cr><cr>" -- "Copy file content to clipboard"
lvim.keys.normal_mode["<C-q>"] = ": BufDel<cr>"
lvim.lsp.buffer_mappings.normal_mode["<C-[>"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Move to prev diagnostic" }
lvim.lsp.buffer_mappings.normal_mode["<C-]>"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Move to next diagnostic" }
lvim.lsp.buffer_mappings.normal_mode["gR"] = { "<cmd>lua require('lvim-functions').rename_symbol()<cr>", "Rename Symbol" }
lvim.builtin.which_key.mappings["t"] = {
    name = "+Terminal",
    f = { "<cmd>ToggleTerm<cr>", "Floating Terminal" },
    v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split Vertical" },
    h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split Horizontal" },
}
-- goto-preview
lvim.keys.normal_mode["P"] = "<cmd>lua require('goto-preview').goto_preview_definition()<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>lua require('goto-preview').close_all_win()<cr>"
-- nvim-tree
lvim.keys.normal_mode["<C-r>"] = "<cmd>NvimTreeFocus<cr>"
lvim.keys.normal_mode["<TAB>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-TAB>"] = ":bprev<cr>"
-- symbols-outline
lvim.keys.normal_mode["<C-l>"] = "<cmd>SymbolsOutline<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<cr>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<cr>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "onedark"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.lualine.style = "lvim"

-- nvim-tree
lvim.builtin.nvimtree.setup.filters.custom = { ".git$", "__pycache__", ".mypy_cache", ".null-ls*" }
lvim.builtin.nvimtree.setup.filters.dotfiles = false
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"

lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "float"
lvim.builtin.terminal.shell = "/usr/local/bin/zsh"
-- lvim.builtin.terminal.open_mapping = [[<C-`>]]

-- tree-sitter
lvim.builtin.treesitter.auto_install = false
lvim.builtin.treesitter.ensure_installed = {}
-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup {
    { command = "black",    filetypes = { "python" },                          extra_args = { "--line-length", "150" } },
    { command = "isort",    filetypes = { "python" },                          extra_args = { "--line-length", "150" } },
    { command = "prettier", filetypes = { "javascript", "typescript", "vue" }, extra_args = { "--tab-width", "2" } },
    { command = "jq",       filetypes = { "json" },                            extra_args = { "--indent", "2" } },
}

local linters = require("lvim.lsp.null-ls.linters")
linters.setup {
    { command = "flake8", filetypes = { "python" }, extra_args = { "--ignore=E203,E501,W503" }, },
    { command = "mypy",   filetypes = { "python" }, },
}

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
local PLUGIN_SETUP = require("lvim-plugin-setup")
lvim.plugins = {
    { "olimorris/onedarkpro.nvim" },
    { "f-person/git-blame.nvim" },
    { "nacro90/numb.nvim",             config = PLUGIN_SETUP.setup_numb_on_setup,  event = "BufRead", },
    { "rmagatti/goto-preview",         config = PLUGIN_SETUP.setup_goto_preview },
    { "simrat39/symbols-outline.nvim", config = PLUGIN_SETUP.setup_symbols_outline },
    { "folke/todo-comments.nvim",      config = PLUGIN_SETUP.setup_todo_comments },
    { "ojroques/nvim-bufdel",          config = PLUGIN_SETUP.setup_nvim_bufdel },
    { "ray-x/lsp_signature.nvim",      config = PLUGIN_SETUP.setup_lsp_signature },
    -- { "karb94/neoscroll.nvim",         config = PLUGIN_SETUP.setup_neoscroll,      event = "WinScrolled", },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
local AUTOCMD = require("lvim-autocmd")
-- nvim-tree
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = AUTOCMD.open_nvim_tree })
vim.api.nvim_create_autocmd({ "WinClosed" }, { callback = AUTOCMD.close_nvim_tree, nested = true })
