--------------------------------------------------------------------------------
-- Autocommands — ported from ~/.vimrc.
--------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Filetype-specific indentation.
autocmd("FileType", {
  group = augroup("filetype_indent", { clear = true }),
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

autocmd("FileType", {
  group = augroup("filetype_indent_go", { clear = true }),
  pattern = { "go" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false -- Go uses tabs
  end,
})

autocmd("FileType", {
  group = augroup("filetype_notabs", { clear = true }),
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false -- Makefiles require real tabs
  end,
})

autocmd("FileType", {
  group = augroup("filetype_indent_yaml", { clear = true }),
  pattern = { "yaml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Trim trailing whitespace on save (preserving cursor position).
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    -- Only touch normal file buffers; skip special buffers (checkhealth,
    -- help, terminals, prompts) where a substitute would error.
    if vim.bo.buftype ~= "" then
      return
    end
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Briefly highlight yanked text (neovim productivity extra).
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- Return to the last cursor position when reopening a file.
autocmd("BufReadPost", {
  group = augroup("last_position", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
