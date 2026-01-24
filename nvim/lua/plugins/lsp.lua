return {
	-- Automatic signature help as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("lsp_signature").setup({
				hint_enable = false, -- Disable virtual text hints
				max_width = 80, -- Max width of signature help window
				handler_opts = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()

			-- Configure LSP floating windows with max width and borders
			local float_opts = {
				border = "rounded",
				max_width = 80,
				max_height = 30,
			}

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

			-- Auto-install these LSP servers and formatters
			local ensure_installed = { "lua-language-server", "typescript-language-server", "prettier", "stylua" }
			local registry = require("mason-registry")
			for _, name in ipairs(ensure_installed) do
				local package = registry.get_package(name)
				if not package:is_installed() then
					package:install()
				end
			end

			-- Get enhanced capabilities from nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP keybindings
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }

					-- Navigation (using Telescope)
					local builtin = require("telescope.builtin");
					vim.keymap.set("n", "gr", builtin.lsp_references, opts);
					vim.keymap.set("n", "gd", builtin.lsp_definitions, opts);
					vim.keymap.set("n", "gi", builtin.lsp_implementations, opts);
					-- Info & Actions
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<D-.>", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<D-r>", function()
						vim.ui.input({ prompt = "Rename: " }, function(new_name)
							if new_name and #new_name > 0 then
								vim.lsp.buf.rename(new_name);
							end
						end);
					end, opts)

					-- Diagnostics
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

					-- Symbols (using Telescope)
					vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, opts);
					vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts);

					-- Call Hierarchy
					vim.keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, opts)
					vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, opts)
				end,
			})

			-- Configure LSP servers
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".git" },
				capabilities = capabilities,
			})
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				root_markers = { "package.json", "tsconfig.json", ".git" },
				capabilities = capabilities,
				commands = {
					["_typescript.applyCodeActionCommand"] = function()
						-- Handled by the server, just acknowledge it
					end,
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							includeCompletionsForModuleExports = true,
							includeAutomaticOptionalChainCompletions = true,
						},
					},
					javascript = {
						suggest = {
							includeCompletionsForModuleExports = true,
							includeAutomaticOptionalChainCompletions = true,
						},
					},
				},
			})

			-- Enable them
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
		end,
	},
}
