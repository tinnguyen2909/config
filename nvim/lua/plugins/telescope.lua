return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				oldfiles = {
					cwd_only = true,
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
	end,
}
