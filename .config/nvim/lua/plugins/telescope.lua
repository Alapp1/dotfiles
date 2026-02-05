return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    
    -- Setup telescope with your custom config
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", "%.git/" },
      },
      pickers = {
        find_files = {
          hidden = true,  -- Show hidden files
        },
      },
    })
    
    -- Keybinds
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search text" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })  -- Keep your Ctrl+p
  end,
}
