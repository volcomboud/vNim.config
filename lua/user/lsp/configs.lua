local status_ok, mason_lspconfig = pcall(require,"mason-lspconfig")
  if not status_ok then
    return
  end


 local servers = {
  "jsonls",
  "sumneko_lua",
  "angularls",
  "eslint_d",
  "html",
  "jdtls",
  "tsserver",
  "prismals",
  "rust_analyzer",
  "taplo"
  }
mason_lspconfig.setup{

  DEFAULT_SETTINGS = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust-analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {
      servers
 },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
  }
}
local lspconfig = require("lspconfig")
--[[ local masonlsp = require("mason-lspconfig")
 local servers = {
   "jsonls",
   "sumneko_lua",
   "angularls",
   "eslint_d",
   "html",
   "jdtls",
   "tsserver",
   "prismals",
   "rust_analyzer",
   "taplo"
 }
]]
--  lsp_installer.setup({
--    ensure_installed = servers,
--  })

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

