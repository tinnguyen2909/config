return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python",
				"markdown",
				"lua",
				"javascript",
				"yaml",
				"typescript",
				"html",
				"css",
				"jsonc",
				"tsx",
			},
			highlight = {
				enable = true,
			},
		})
	end,
}
