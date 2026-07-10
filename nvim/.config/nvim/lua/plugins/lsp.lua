--------------------------------------------------------------------------------
-- LSP — language servers via mason, wired to nvim-cmp for completion.
--
-- Servers listed in `servers` below are auto-installed by mason on first
-- launch and configured here. Add more by dropping a name into the table
-- (browse available names with :Mason). Some servers need a language
-- toolchain present (e.g. gopls needs Go); mason installs the server binary,
-- not the toolchain.
--------------------------------------------------------------------------------
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Servers to auto-install and configure.
    -- Keys are lspconfig server names; values are per-server overrides.
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }, -- recognise the `vim` global
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
      -- Uncomment (and install the underlying toolchain) as needed:
      -- pyright = {},
      -- gopls = {},
      -- ts_ls = {},
      -- rust_analyzer = {},
      -- bashls = {},
      -- jsonls = {},
      -- yamlls = {},
    }

    -- Diagnostic display.
    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      float = { border = "rounded", source = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
    })

    -- Buffer-local keymaps, applied whenever a server attaches.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
      callback = function(ev)
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gi", vim.lsp.buf.implementation, "Go to implementation")
        map("gr", vim.lsp.buf.references, "References")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
        map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
        map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
        map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
      end,
    })

    -- Install the servers via mason. nvim-lspconfig ships each server's base
    -- config under `lsp/<name>.lua`, consumed by the native vim.lsp API below.
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_enable = false, -- we enable servers explicitly below
    })

    -- Advertise nvim-cmp's capabilities to every server (native 0.11+ API).
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- Layer per-server overrides on top of nvim-lspconfig's defaults, then enable.
    for name, opts in pairs(servers) do
      if next(opts) ~= nil then
        vim.lsp.config(name, opts)
      end
    end
    vim.lsp.enable(vim.tbl_keys(servers))
  end,
}
