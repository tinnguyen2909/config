local packages_to_install = { "stylua", "prettier" }

return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "pyright", "ruff", "ts_ls" },
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			config = function()
				require("mason").setup()
				local registry = require("mason-registry")
				for _, pkg_name in ipairs(packages_to_install) do
					local ok, pkg = pcall(registry.get_package, pkg_name)
					if ok then
						if not pkg:is_installed() then
							pkg:install()
						end
					end
				end
			end,
		},
		"neovim/nvim-lspconfig",
	},
}
