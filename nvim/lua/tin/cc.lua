local M = {}

local claude_terminal = nil

function M.setup()
	if not claude_terminal then
		local Terminal = require("toggleterm.terminal").Terminal
		claude_terminal = Terminal:new({
			cmd = "claude",
			dir = "git_dir",
			direction = "float",
			name = "cc",
			float_opts = {
				border = "double",
				title_pos = "center",
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			on_close = function(term)
				vim.cmd("startinsert!")
			end,
		})
	end
end

function M.toggle()
	if not claude_terminal then
		M.setup()
	end
	claude_terminal:toggle()
end

return M
