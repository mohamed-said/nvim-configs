-- snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- `eslint` lang server setup through lspconfig
-- vscode-langservers-extracted@4.1.0 → https://github.com/hrsh7th/vscode-langservers-extracted
nvim_lsp.eslint.setup {
  on_attach = function(client)
    -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
    -- the resolved/server capabilities of the eslint server ourselves!
    client.server_capabilities.document_formatting = true
  end,
  settings = {
    format = { enable = true },
  },
}

-- Enable rust_analyzer
-- rust-analyzer d12130797 2022-05-12 dev
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      -- cargo = { loadOutDirsFromCheck = true },
      -- procMacro = { enable = true },
      -- hoverActions = { references = true },
    },
  },
}

-- rust-tools config: https://github.com/simrat39/rust-tools.nvim
-- @TODOUA: selects on *abbles require manual close with no select
-- ... not handling nil in select telescope or otherwise
require("rust-tools").setup {
  tools = {
    inlay_hints = {
      -- prefix for parameter hints
      parameter_hints_prefix = " ",

      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = " ",
    },
  },
}

local border_style = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local pop_opts = { border = border_style }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
