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

  -- Live colour swatches: highlights hex codes (#89b4fa), rgb()/hsl(), and
  -- named colours in their actual colour, so tmux.conf palettes etc. preview.
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      user_default_options = {
        names = false,       -- don't colour bare words like "red"/"blue"
        RGB = true,          -- #RGB
        RRGGBB = true,       -- #RRGGBB
        RRGGBBAA = true,     -- #RRGGBBAA
        rgb_fn = true,       -- rgb()/rgba()
        hsl_fn = true,       -- hsl()/hsla()
        mode = "background", -- paint the swatch behind the code
      },
    },
  },
}
