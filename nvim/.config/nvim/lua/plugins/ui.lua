--------------------------------------------------------------------------------
-- UI — colorscheme, statusline, file explorer, keymap hints, indent guides.
--------------------------------------------------------------------------------
return {
  -- Catppuccin mocha, matching the tmux theme.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- load before other plugins so the theme applies first
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = true,
        neotree = true,
        native_lsp = { enabled = true },
        mason = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Statusline.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        -- catppuccin ships per-flavour lualine themes (no generic "catppuccin").
        theme = "catppuccin-mocha",
        globalstatus = true,
        section_separators = "",
        component_separators = "|",
      },
      sections = {
        lualine_c = { { "filename", path = 1 } }, -- relative path
      },
    },
  },

  -- File explorer.
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = { hide_dotfiles = false, hide_gitignored = false },
      },
    },
  },

  -- Popup showing available keybindings after leader.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Indentation guides.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = { indent = { char = "│" }, scope = { enabled = true } },
  },
}
