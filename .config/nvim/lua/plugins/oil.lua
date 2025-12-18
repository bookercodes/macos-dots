return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
				default_file_explorer = true,

				-- Columns to show
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},

				-- Delete to trash instead of permanently deleting
				delete_to_trash = true,

				-- Skip confirmation for simple operations
				skip_confirm_for_simple_edits = true,

				-- Keymaps in oil buffer
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-v>"] = "actions.select_vsplit",
					["<C-x>"] = "actions.select_split",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["g."] = "actions.toggle_hidden",
					["<Esc>"] = "actions.close",
				},

				-- Show hidden files by default
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, _)
						return name == ".." or name == ".git"
					end,
				},
			})

			-- Open parent directory in current window (vinegar style)
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
}
