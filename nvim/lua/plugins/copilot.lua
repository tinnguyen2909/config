return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		-- Accept suggestions with Ctrl+J instead of Tab
		vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.g.copilot_no_tab_map = true
		
		-- Additional useful mappings
		vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
		vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)")
		vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)")
		vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)")
	end,
}

