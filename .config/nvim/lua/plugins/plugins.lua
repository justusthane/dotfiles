if vim.loop.os_uname().sysname == "Windows_NT" then
	pwsh_path = 'C:/Program Files/WindowsApps/Microsoft.PowerShell_7.6.1.0_x64__8wekyb3d8bbwe/pwsh.exe'
else
	pwsh_path = 'pwsh'
end
return {
	{
		'TobinPalmer/pastify.nvim',
		cmd = { 'Pastify', 'PastifyAfter' },
		config = function()
			require('pastify').setup {
				opts = {
					absolute_path = true,
					local_path = 'D:/Users/jbadergr/OneDrive - Confederation College/Documents/2. Areas/tech-services-wiki.wiki/uploads',
				},
			}
		end
	},

	{
		'morhetz/gruvbox',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"vim-scripts/headers.vim",
		-- lazy-load on filetype
		ft = "headers",
		-- options for neorg. This will automatically call `require("neorg").setup(opts)`
	},
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"TheLeoP/powershell.nvim",
		---@type powershell.user_config
		opts = {
			bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
			shell = pwsh_path
		}
	},
 {'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
}
