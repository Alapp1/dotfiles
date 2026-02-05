return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",  -- Load when you enter insert mode
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")
    
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),      -- Next suggestion
        ["<C-p>"] = cmp.mapping.select_prev_item(),      -- Previous suggestion
        ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept suggestion
        ["<C-Space>"] = cmp.mapping.complete(),          -- Trigger completion
        ["<C-e>"] = cmp.mapping.abort(),                 -- Close completion
      }),
      sources = {
        { name = "nvim_lsp" },  -- LSP suggestions
        { name = "buffer" },    -- Words from current file
        { name = "path" },      -- File paths
      },
    })
  end,
}
