--Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.colorscheme = "oh-lucy-evening"

vim.o.clipboard = "unnamedplus"
lvim.reload_config_on_save = true

-- Buffering
lvim.keys.normal_mode["<leader>x"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<leader>c"] = false

lvim.keys.normal_mode["<leader>vs"] = ":vsplit<CR>"
lvim.keys.normal_mode["<leader>hs"] = ":split<CR>"

-- Terminal
lvim.builtin.terminal.open_mapping = "<c-t>"

-- Plugins Here
lvim.plugins = {
  "Yazeed1s/oh-lucy.nvim",
  "terryma/vim-multiple-cursors",
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
  {
    "AckslD/swenv.nvim",
    config = function()
      require("swenv").setup({
        venvs_path = vim.fn.expand('~/.cache/pypoetry/virtualenvs'),
        post_set_venv = function()
          vim.cmd("LspRestart")
        end
      })
    end
  },
  "stevearc/dressing.nvim",
  "wakatime/vim-wakatime",
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({})
    end
  },
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Venv" }
}

lvim.builtin.treesitter.ensure_installed = {
  "python",
  "php",
  "go"
}

lvim.lsp.automatic_servers_installation = false

lvim.builtin.mason.ensure_installed = {
  "prettier",
  "eslint",
  "phpactor",
  "gopls",
  "revive",
  "shellcheck",
  "black",
  "flake8",
  "refactoring"
}

-- Globals
local jsDevFiles = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" }
-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    filetypes = jsDevFiles
  },
  {
    name = "black",
    filetype = "python"
  }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "flake8",
    args = { "--ignore=E203" },
    filetypes = { "python" }
  },
  {
    name = "shellcheck",
    args = { "--severity", "warning" }
  },
  {
    name = "psalm",
    filetypes = { "php" }
  },
  {
    name = "revive",
    filetypes = { "go" }
  },
  {
    name = "eslint",
    filetypes = jsDevFiles
  }
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "refactoring",
    filetypes = { "typescript", "typescriptreact", "python", "lua", "javascript", "go" }
  }
}

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.tsx", "*.lua", "*.py", "*.php", "!*.blade.php", "*.js", "*.ts", "*.vue", "*.go" }
