return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp");

			cmp.setup({
				-- Auto-select first item
				preselect = cmp.PreselectMode.Item,

				-- Completion sources
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),

				-- Keybindings with arrow keys and Enter
				mapping = cmp.mapping.preset.insert({
					["<Down>"] = cmp.mapping.select_next_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm with Enter
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete(), -- Manual trigger
					["("] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true });
							vim.api.nvim_feedkeys("(", "n", true);
						else
							fallback();
						end
					end, { "i" }),
				}),

				-- Minimal completion behavior
				completion = {
					completeopt = "menu,menuone",
				},
			});
		end,
	},
};
