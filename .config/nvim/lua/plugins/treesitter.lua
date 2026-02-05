return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "c", "lua", "python", "javascript", "typescript" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
