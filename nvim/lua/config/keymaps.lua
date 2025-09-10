local telescope_utils = require("config.telescope-utils")
local dropbar_utils = require("utils.dropbar_utils")

-- Terminal mode
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- LSP keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic quickfix" })

-- Telescope
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<cr>", { desc = "Open Telescope" })
vim.keymap.set(
	"n",
	"<leader><Space>",
	"<cmd>Telescope builtin include_extensions=true<cr>",
	{ desc = "Open Telescope" }
)
vim.keymap.set("n", "<space>ff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep_args<cr>", { desc = "Live grep with args" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- Git (if you add gitsigns keymaps)
vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk" })
vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })

-- Quick navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Zen Mode
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })

-- Dropbar
dropbar_utils.setup_keymaps()

-- Copy text
vim.keymap.set("n", "<C-c>", "<cmd>CopyText<cr>", { desc = "Copy selected text or entire buffer" })
vim.keymap.set("v", "<C-c>", "<cmd>CopyText<cr>", { desc = "Copy selected text" })

-- Clear search highlight with ESC (only when search is active)
vim.keymap.set("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	else
		return "<Esc>"
	end
end, { expr = true, desc = "Clear search highlight" })
