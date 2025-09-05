return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 0.9,
			width = 0.8,
		},
		plugins = {
			options = {
				number = true,
				relativenumber = true,
				list = true,
			},
		},
		on_open = function()
			vim.keymap.set("n", "<Esc>", "<cmd>ZenMode<cr>", { buffer = true, desc = "Exit Zen Mode" })
		end,
		on_close = function()
			vim.keymap.del("n", "<Esc>", { buffer = true })
		end,
	},
}
