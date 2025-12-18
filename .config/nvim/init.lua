-- Set leader key before loading plugins
vim.g.mapleader = " "

-- Your existing settings
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.undofile = true
vim.o.cursorline = true
vim.wo.relativenumber = true
vim.o.autoread = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.o.laststatus = 3 -- Global statusline

-- Custom statusline
local function get_git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	return branch ~= "" and " " .. branch or ""
end

function _G.statusline()
	return table.concat({
		" %f", -- File path
		"%m", -- Modified flag
		"%r", -- Readonly flag
		get_git_branch(), -- Git branch
		"%=", -- Right align
		"%y", -- File type
		" %{&fileencoding?&fileencoding:&encoding}", -- Encoding
		" %l:%c ", -- Line:Column
		"%p%% ", -- Percentage through file
	})
end

vim.o.statusline = "%!v:lua.statusline()"

-- Show diagnostics inline
vim.diagnostic.config({
	virtual_text = true,
})

-- Disable command-line window
vim.keymap.set("n", "q:", "<nop>")

-- Command+S to save file
vim.keymap.set("n", "<D-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<D-s>", "<Esc>:w<CR>", { silent = true })

-- Navigate between splits with Ctrl+hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Navigate between splits with Alt+hl
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Move to right split" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Auto-reload files when changed outside Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

require("config.lazy")
