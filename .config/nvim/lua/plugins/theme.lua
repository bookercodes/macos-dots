return {
	{
		"baliestri/aura-theme",
		lazy = false,
		priority = 1000,
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		priority = 999,
		config = function()
			require("auto-dark-mode").setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.cmd([[colorscheme aura-dark]])
				end,
				set_light_mode = function()
					vim.cmd([[colorscheme github_light]])
				end,
			})
		end,
	},
}
