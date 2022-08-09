-- install packer automatically on new system
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

-- sync plugins on write/save
vim.api.nvim_create_augroup("SyncPackerPlugins", {})
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerSync", pattern = "plugins.lua", group = "SyncPackerPlugins" }
)

-- ******Treesitter-refactor******

-- Highlight definitions
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
  },
}

-- Highlight current scope
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_current_scope = { enable = true },
  },
}

-- Smart rename
-- Renames the symbol under the cursor within the current scope (and current file).
require'nvim-treesitter.configs'.setup {
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}

-- Navigation
-- Provides "go to definition" for the symbol under the cursor, and lists the definitions from the current file.
-- If you use goto_definition_lsp_fallback instead of goto_definition
-- in the config below vim.lsp.buf.definition is used if nvim-treesitter can not resolve the variable.
-- goto_next_usage/goto_previous_usage go to the next usage of the identifier under the cursor.
require'nvim-treesitter.configs'.setup {
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}
-- ********Treesitter-refactor********



-- Plugins via Packer
return require("packer").startup {
  function(use)
    use "rust-lang/rust.vim"
    use 'folke/tokyonight.nvim'
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
}




