local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.setup({ virtual_text = true })

vim.diagnostic.config({ virtual_text = true })

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "rust_analyzer" },
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})
local lspconfig = require("lspconfig")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- loca

-- lspconfig.efm.setup({
-- 	init_options = { documentFormatting = true },
-- 	settings = {
-- 		rootMarkers = { ".git/" },
-- 		languages = {
-- 			lua = { require("efmls-configs.linters.luacheck"), require("efmls-configs.formatters.stylua") },
-- 			go = {
-- 				-- require("efmls-configs.linters.golangci_lint"),
-- 				require("efmls-configs.formatters.gofmt"),
-- 				require("efmls-configs.formatters.goimports"),
-- 				require("efmls-configs.formatters.golines"),
-- 				require("efmls-configs.formatters.eslint"),
-- 				require("efmls-configs.linters.eslint"),
-- 			},
--       python = {
--         require("efmls-configs.linters.mypy"),
--       }
-- 		},
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		if client.supports_method("textDocument/formatting") then
-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup,
-- 				buffer = bufnr,
-- 				callback = function()
-- 					vim.lsp.buf.format({ bufnr = bufnr })
-- 					-- vim.cmd(":Format<CR>")
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })
--


vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	{ "williamboman/mason-lspconfig.nvim" },
	update_in_insert = true,
})

local caps = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities(),
	-- File watching is disabled by default for neovim.
	-- See: https://github.com/neovim/neovim/pull/22405
	{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	},
	formatting = lsp.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

-- lspconfig.lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 		},
-- 	},
-- })
--
-- lspconfig.clangd.setup({})
--
-- lspconfig.rust_analyzer.setup({})
--
-- lspconfig.tsserver.setup({
-- 	on_attach = function(client)
-- 		client.resolved_capabilities.document_formatting = false
-- 		client.resolved_capabilities.document_range_formatting = false
-- 	end,
-- })
--
-- lspconfig.eslint.setup({})
--
-- lspconfig.gopls.setup({
-- 	on_attach = function(client)
-- 		client.resolved_capabilities.document_formatting = false
-- 		client.resolved_capabilities.document_range_formatting = false
-- 	end,
-- 	cmd = { "gopls" },
-- 	filetypes = { "go", "gomod", "gowork", "tmpl" },
-- 	settings = { gopls = { completeUnimported = true, usePlaceholders = true, analyses = { unusedparams = true } } },
-- })
--
-- lspconfig.gdscript.setup({})
-- lspconfig.nil_ls.setup({
-- 	autostart = true,
-- 	capabilities = caps,
-- 	settings = {
-- 		["nil"] = {
-- 			testSetting = 42,
-- 			formatting = {
-- 				command = { "nixpkgs-fmt" },
-- 			},
-- 		},
-- 	},
-- })
-- lspconfig.svelte.setup({})
-- lspconfig.nixd.setup({})
--
--
-- lspconfig.gdscript.setup()

lspconfig.gdscript.setup({})

local fqbn = "esp8266:esp8266:nodemcuv2"
lspconfig.arduino_language_server.setup({
	cmd = {
		"arduino-language-server",
		"-cli-config",
		"/home/tom/.arduino15/arduino-cli.yaml",
		"-fqbn",
		fqbn,
	},

	on_attach = on_attach,
	--capabilities = capabilities,
})

--
-- local arduino = require("arduino-nvim").setup({
-- 	default_fqbn = "esp8266:esp8266:nodemcuv2",
--
-- 	--Path to clangd (all paths must be full)
-- 	clangd = require("mason-core.path").bin_prefix("clangd"),
--
-- 	--Path to arduino-cli
-- 	arduino = "/usr/bin/arduino-cli",
--
-- 	--Data directory of arduino-cli
-- 	arduino_config_dir = "/home/tom/.arduino15",
--
-- 	--Extra options to arduino-language-server
-- 	extra_opts = { ... },
-- })
--
-- require("lspconfig")["arduino_language_server"].setup({
-- 	on_new_config = arduino.on_new_config,
-- })
