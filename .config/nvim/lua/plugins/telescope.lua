return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					-- Performance improvements
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden", -- Search hidden files
						"--glob=!.git/", -- But exclude .git
					},

					-- Ignore patterns for common files/directories you don't want
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"%.lock",
						"package%-lock%.json",
						"yarn%.lock",
						"target/", -- Rust
						"build/",
						"dist/",
						"%.o",
						"%.a",
						"%.out",
						"%.pdf",
						"%.mkv",
						"%.mp4",
						"%.zip",
						"%.tar",
						"%.tar%.gz",
						"%.jpg",
						"%.jpeg",
						"%.png",
						"%.gif",
						"%.svg",
						"%.ico",
					},

					-- Layout configuration for better visibility
					layout_config = {
						horizontal = {
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},

					-- Sorting and selection
					sorting_strategy = "ascending",
					selection_strategy = "reset",
					scroll_strategy = "cycle",

					-- UI improvements
					prompt_prefix = "🔍 ",
					selection_caret = "➜ ",
					entry_prefix = "  ",
					border = true,
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

					-- Performance
					cache_picker = {
						num_pickers = 10,
					},
					dynamic_preview_title = true,
				},

				pickers = {
					find_files = {
						-- Search hidden files but respect .gitignore
						hidden = true,
						-- Use fd if available for better performance
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git/" },
					},
					live_grep = {
						additional_args = function()
							return { "--hidden" };
						end,
					},
					buffers = {
						sort_lastused = true,
						sort_mru = true,
					},
				},
			})

			local builtin = require("telescope.builtin");
			vim.keymap.set("n", "<D-p>", builtin.find_files, { desc = "Find files" });
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep files" });
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" });
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" });
		end,
	},
}
