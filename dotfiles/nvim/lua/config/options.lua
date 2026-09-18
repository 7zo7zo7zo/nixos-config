local options = {
	showtabline = 2,
	backup = false,
	writebackup = false,
	swapfile = false,
	undofile = false,
	shiftwidth = 2,
	tabstop = 2,
	expandtab = true,
	clipboard = vim.env.SSH_TTY and "" or "unnamedplus",
	cursorline = true,
	autoindent = true,
	smartindent = false,
	smoothscroll = true,
	number = true,
	relativenumber = true,
	ignorecase = true,
	smartcase = true,
	hlsearch = true,
	termguicolors = true,
	encoding = "UTF-8",
	wrap = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
