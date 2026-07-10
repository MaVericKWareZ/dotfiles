--------------------------------------------------------------------------------
-- Treesitter — accurate syntax highlighting, indentation, and text objects.
--------------------------------------------------------------------------------
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- stable classic API; `main` is an incompatible rewrite
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash", "c", "css", "dockerfile", "go", "html", "javascript",
      "json", "lua", "luadoc", "make", "markdown", "markdown_inline",
      "python", "query", "regex", "rust", "toml", "tsx", "typescript",
      "vim", "vimdoc", "yaml",
    },
    auto_install = true,     -- install parsers for new filetypes on the fly
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
      },
    },
  },
}
