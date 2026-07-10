--------------------------------------------------------------------------------
-- lazy.nvim bootstrap
-- Clones the plugin manager on first launch, then imports lua/plugins/.
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false }, -- don't auto-check for plugin updates
  change_detection = { notify = false },
  -- No plugin here needs luarocks; disable the whole rocks subsystem so
  -- :checkhealth doesn't warn about a missing luarocks/hererocks install.
  rocks = { enabled = false },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      -- Disable unused built-in plugins for faster startup.
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
