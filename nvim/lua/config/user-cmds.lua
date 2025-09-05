vim.api.nvim_create_user_command("DumpOptions", function()
	-- Create a scratch buffer
	local buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]

	-- Get all options info
	local opts_info = vim.api.nvim_get_all_options_info()
	local lines = {}

	for name, _ in pairs(opts_info) do
		local ok, value = pcall(vim.api.nvim_get_option_value, name, { scope = "local" })
		if ok then
			table.insert(lines, string.format("%-20s = %s", name, vim.inspect(value)))
		end
	end

	-- Set lines to buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Open in a new split window
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
		row = math.floor(vim.o.lines * 0.1),
		col = math.floor(vim.o.columns * 0.1),
		style = "minimal",
		border = "single",
	})
end, {})

vim.api.nvim_create_user_command("Claude", function(opts)
	require("tin.cc").toggle(opts.args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("FloatTerm", function(opts)
	require("toggleterm").toggle(nil, nil, nil, "float")
end, {})
