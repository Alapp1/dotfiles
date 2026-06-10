return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "bash", "c", "cpp", "diff", "dockerfile", "html", "javascript",
            "json", "lua", "markdown", "markdown_inline", "python", "regex",
            "sql", "toml", "typescript", "vim", "vimdoc", "yaml",
        }

        require("nvim-treesitter").install(parsers)

        -- Build filetype list from parsers, since some parsers map to
        -- filetypes with different names (or multiple filetypes).
        local patterns = {}
        for _, parser in ipairs(parsers) do
            for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
                table.insert(patterns, ft)
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = patterns,
            callback = function(args)
                -- highlighting
                vim.treesitter.start()
                -- folding
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo.foldmethod = "expr"
                -- indent
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
