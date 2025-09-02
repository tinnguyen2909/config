local M = {}

local claude_terminal = nil

function M.toggle(args)
	local cmd = "claude"
	if args and args ~= "" then
		cmd = cmd .. " " .. args
	end

	require("toggleterm").exec(cmd, nil, nil, "git_dir", "float", "cc")
end

return M
