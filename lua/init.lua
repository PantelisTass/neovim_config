 -- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },       -- LSP completions
    { name = 'ultisnips' },      -- UltiSnips completions
    { name = 'buffer' },         -- Buffer completions
    { name = 'path' },           -- Path completions
    { name = 'nvim_lua' },       -- Lua completions for Neovim config
  })
})

-- Set up LSP for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require'lspconfig'

-- Example LSP setup (e.g., Python)
lspconfig.pyright.setup{
  capabilities = capabilities,
}

-- Ensure nvim-lspconfig is installed
require'lspconfig'.texlab.setup{}

-- Alternatively, you can set up digestif like this:
-- require'lspconfig'.digestif.setup{}

-- Optional: Configure additional settings
require'lspconfig'.texlab.setup{
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = true
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = true
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        executable = nil,  -- Set this to your PDF viewer executable
        args = {}
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = true
      }
    }
  }
}

