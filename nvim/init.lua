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
vim.o.splitright = true -- Open vertical splits to the right

-- Custom statusline
local git_branch = ""

local function update_git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	git_branch = branch ~= "" and branch or ""
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "DirChanged" }, {
	callback = update_git_branch,
})

local function get_diagnostics()
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local parts = {}
	if errors > 0 then
		table.insert(parts, "%#DiagnosticError# " .. errors .. "%*")
	end
	if warnings > 0 then
		table.insert(parts, "%#DiagnosticWarn# " .. warnings .. "%*")
	end
	return table.concat(parts, " ")
end

function _G.statusline()
	local ft = vim.bo.filetype

	-- Oil: show clean directory path
	if ft == "oil" then
		local dir = vim.fn.expand("%"):gsub("^oil://", ""):gsub(vim.env.HOME, "~")
		return " " .. dir
	end

	local diag = get_diagnostics()
	return table.concat({
		" %f%m%r",
		"%=",
		diag ~= "" and diag .. "  " or "",
		git_branch ~= "" and " " .. git_branch .. "  " or "",
		"%y ",
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

-- Navigation handled by vim-tmux-navigator plugin

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
