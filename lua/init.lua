-- Utility function to handle termcodes
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Function to check if the cursor is at the beginning of the line or after whitespace
local function check_backspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)  -- For UltiSnips integration
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(ultisnips-jump-forward)", true, true, true), "m", true)
      elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#ExpandSnippet()<CR>", true, true, true), "m", true)
	else
        fallback()
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        vim.fn.feedkeys(t('<Plug>(ultisnips_jump_backward)'), '')
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- UltiSnips source
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Setup LSP for LaTeX
local lspconfig = require'lspconfig'

lspconfig.texlab.setup {
  capabilities = require'cmp_nvim_lsp'.default_capabilities(),
  on_attach = function(client, bufnr)
    -- Additional LSP settings for LaTeX
    local buf_map = function(bufnr, mode, lhs, rhs, opts)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {silent = true})
    end

    -- Example: key mapping for LaTeX LSP
    buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  end,
  settings = {
    texlab = {
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
	ignoreWarnings = { "24" }, -- Disable "missing $" error,
      },
    },
  },
}

-- Specific setup for LaTeX files
cmp.setup.filetype('tex', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
  })
})


-- Map Tab in visual mode to save the visual selection using UltiSnips
vim.api.nvim_set_keymap('v', '<Tab>', ':call UltiSnips#SaveLastVisualSelection()<CR>gv', { noremap = true, silent = true })

-- Map Tab in visual mode to save the visual selection using UltiSnips
vim.api.nvim_set_keymap('i', '<Tab>', ':call UltiSnips#SaveLastVisualSelection()<CR>gv', { noremap = true, silent = true })


