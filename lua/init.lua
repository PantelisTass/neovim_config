-- Utility function to handle termcodes
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Function to check if the cursor is at the beginning of the line or after whitespace
local function check_backspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Setup UltiSnips options
vim.g.UltiSnipsExpandTrigger = "<CR>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
-- Set UltiSnips directories in Lua
vim.g.UltiSnipsSnippetDirectories = { "UltiSnips" }

-- Use Tab to save visual selection in visual mode
vim.api.nvim_set_keymap('v', '<Tab>', ':<C-u>call UltiSnips#SaveLastVisualSelection()<CR>gvs', { noremap = true, silent = true })


local cmp = require('cmp')

-- Helper function to check if there's a word before the cursor
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)  -- Use UltiSnips to expand snippets
    end,
  },
  mapping = {
    -- Tab to navigate the completion menu or jump through UltiSnips placeholders
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()  -- Navigate to the next item in the completion menu
      elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, true, true), "m", true)
      elseif has_words_before() then
        cmp.complete()  -- If there are words before the cursor, trigger the completion
      else
        fallback()  -- Insert a regular tab character if no other conditions are met
      end
    end, { "i", "s" }),

    -- Shift-Tab to navigate backwards in the completion menu or UltiSnips placeholders
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()  -- Navigate to the previous item in the completion menu
      elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-k>", true, true, true), "m", true)
      else
        fallback()  -- Default behavior if neither completion nor snippet is active
      end
    end, { "i", "s" }),

    -- Enter key to confirm selection from the completion menu
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },    -- LSP source for autocompletion
    { name = 'ultisnips' },   -- UltiSnips source for snippet completion
  }, {
    { name = 'buffer' },      -- Buffer source for words in the buffer
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


