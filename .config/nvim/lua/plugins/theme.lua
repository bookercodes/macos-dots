return {
	{
		"zenbones-theme/zenbones.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		init = function()
			vim.g.zenbones_italic_strings = false
		end,
	},
	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		priority = 999,
		config = function()
			require("auto-dark-mode").setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.opt.background = "dark"
					vim.cmd([[colorscheme vesper]])
				end,
				set_light_mode = function()
					vim.opt.background = "light"
					vim.cmd([[colorscheme zenbones]])
				end,
			})
		end,
	},
}
