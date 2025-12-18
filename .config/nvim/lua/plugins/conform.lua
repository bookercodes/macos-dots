return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					markdown = { "prettier" },
				},
			})

			-- Format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})

			-- Manual format keybinding
			vim.keymap.set("n", "<leader>fm", function()
				require("conform").format()
			end, { desc = "Format buffer" })
		end,
	},
}
