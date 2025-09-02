local M = {}

function M.file_browser_with_select()
	print("file_browser_with_select")
	require("telescope").extensions.file_browser.file_browser({
		select_buffer = true,
	})
end

return M

