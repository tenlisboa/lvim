-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.colorscheme = "OceanicNext"

-- Buffering
lvim.keys.normal_mode["<leader>x"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<leader>c"] = false

-- Terminal
lvim.builtin.terminal.open_mapping = "<c-t>"

-- Plugins Here
lvim.plugins = {
  "mhartington/oceanic-next",
  "terryma/vim-multiple-cursors",
  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
    }
  }
}

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    filetype = { "typescript", "typescriptreact" }
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "flake8",
    filetypes = { "python" }
  },
  {
    name = "shellcheck",
    args = { "--severity", "warning" }
  },
  { name = "xo" },
  { name = "psalm" },
  { name = "revive" }
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "refactoring",
    filetypes = { "typescript", "typescriptreact", "python", "lua", "javascript", "go" }
  }
}

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.lua", "*.py", "*.php", "*.js", "*.ts", "*.vue", "*.go" }
