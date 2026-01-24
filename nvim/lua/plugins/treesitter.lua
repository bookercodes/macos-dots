return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "typescript", "tsx", "javascript", "markdown", "markdown_inline" },
				auto_install = true,
				highlight = { enable = true },
			})

			-- Use markdown highlighting for .mdx files
			vim.filetype.add({
				extension = {
					mdx = "markdown",
				},
			})
		end,
	},
}
