return {
  -- Mason: installs LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridges Mason and LSP
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "clangd" },
      })
    end,
  },

  -- The actual LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- Add this dependency
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- This function runs when LSP attaches to a file
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      end

      -- New API: vim.lsp.config instead of lspconfig
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      vim.lsp.config("clangd", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Enable the servers
      vim.lsp.enable({"lua_ls", "pyright", "ts_ls", "clangd"})
    end,
  },
}
