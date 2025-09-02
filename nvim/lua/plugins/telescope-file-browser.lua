return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			extensions = {
				file_browser = {
					theme = "dropdown",
					hijack_netrw = true,
					auto_depth = true,
					select_buffer = true,
				},
			},
		})
		require("telescope").load_extension("file_browser")

		vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File Browser" })
	end,
}
