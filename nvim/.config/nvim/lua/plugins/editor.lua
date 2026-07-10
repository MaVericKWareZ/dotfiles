--------------------------------------------------------------------------------
-- Editor — quality-of-life editing plugins.
--------------------------------------------------------------------------------
return {
  -- Auto-close brackets, quotes, etc. Integrates with nvim-cmp.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
      end
    end,
  },

  -- `gcc` to toggle a line comment, `gc` in visual mode.
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Surround text objects: cs"' , ds( , ysiw) , etc.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
