vim.pack.add({
	'https://github.com/saghen/blink.lib',
	'https://github.com/Saghen/blink.cmp',
	{ src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range("v2.*") },
	'https://github.com/saghen/blink.indent',
	'https://github.com/lervag/vimtex',
	'https://github.com/evesdropper/luasnip-latex-snippets.nvim',
	'https://github.com/brenoprata10/nvim-highlight-colors',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/luukvbaal/nnn.nvim',
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/nvim-mini/mini.pairs',
  --'https://github.com/nvim-orgmode/orgmode',
  --'https://github.com/chipsenkbeil/org-roam.nvim'
  --'https://github.com/nvim-orgmode/org-bullets.nvim'
})

--[[
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'org',
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ''
  end,
})

require('org-bullets').setup()

require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',

  mappings = {
    global = {
      org_capture = '<leader>cc',
      org_agenda = '<leader>ca',
    },
  },

  org_capture_templates = {
    i = {
      description = "Inbox",
      template = "* %?\n  Captured: %U",
      target = "~/orgfiles/refile.org",
    },

    t = {
      description = "Task",
      template = "* TODO %?\n  Captured: %U",
      target = "~/orgfiles/tasks.org",
    },

    e = {
      description = "Event",
      template = "* %?\n  %^{When}T",
      target = "~/orgfiles/calendar.org",
    },

    E = {
      description = "Multi-day event",
      template = "* %?\n  %^{Start}T--%^{End}T",
      target = "~/orgfiles/calendar.org",
    },

    s = {
      description = "Scheduled task",
      template = "* TODO %?\n  SCHEDULED: %^{When}T",
      target = "~/orgfiles/tasks.org",
    },
  },

  -- This must be outside org_capture_templates
  org_agenda_custom_commands = {
    d = {
      description = "Day calendar",
      types = {
        {
          type = "agenda",
          org_agenda_span = "day",
        },
      },
    },

    c = {
      description = "Month calendar without classes",
      types = {
        {
          type = "agenda",
          org_agenda_span = "month",
          org_agenda_tag_filter_preset = "-class",
        },
      },
    },
  },
})
]]--

local cmp = require('blink.cmp')

cmp.build():pwait()
cmp.setup({
	keymap = { preset = 'default' },
	completion = { documentation = { auto_show = false } },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      org = {'orgmode'}
    },
    providers = {
      orgmode = {
        name = 'Orgmode',
        module = 'orgmode.org.autocompletion.blink',
        fallbacks = { 'buffer' },
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})


--local pairs = require('blink.pairs')

--pairs.build():pwait()
--pairs.setup()

require('nvim-highlight-colors').setup()

--local nnn_session = "nnn_picker_" .. vim.fn.getpid()

require("nnn").setup({
	picker = {
		--cmd = "tmux new-session -s " .. nnn_session .. " nnn -a",
		cmd = "nnn -a",
		style = { border = "rounded" },
		session = "shared",
	},
	--offset = true,
	replace_netrw = "picker",
})
--[[
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		vim.fn.system("tmux kill-session -t " .. nnn_session .. " 2>/dev/null")
	end,
})
]]--

vim.cmd.colorscheme('kanagawa')

vim.lsp.config("ols", {
  cmd = { "ols" },
  filetypes = { "odin" },
  root_markers = {
    "ols.json",
    "odin.mod",
    ".git",
  },
})

vim.lsp.enable("ols")

require("mini.pairs").setup()
