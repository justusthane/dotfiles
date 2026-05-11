vim.cmd('source ~/dotfiles/vimrc')
-- Set default shell to PowerShell

-- ============================================================================
-- POWERSHELL NEOVIM SETUP — using vim.pack + native vim.lsp.config()
-- Covers:
--   1. Plugin management with vim.pack
--   2. PowerShell syntax highlighting via vim-ps1
--   3. PowerShell Editor Services via Neovim native LSP config
--   4. Reusable terminal split with run-file and run-selection mappings
-- ============================================================================

-- ============================================================================
-- UPDATE THIS to the folder where you extracted PowerShellEditorServices.zip.
-- The path should contain the PowerShellEditorServices/ subdirectory.
-- ============================================================================
-- local ps_bundle_path = vim.fn.expand("~") .. "/AppData/Local/nvim-data/ps_es"
-- macOS / Linux:
local ps_bundle_path = vim.fn.expand("~") .. "/.local/share/nvim/ps_es"

-- ============================================================================
-- 1. PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
  "https://github.com/PProvost/vim-ps1",
  "https://github.com/neovim/nvim-lspconfig",
})

-- ============================================================================
-- 2. BASIC EDITOR SETTINGS
-- ============================================================================
vim.opt.number = true
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- ============================================================================
-- 3. FILETYPE DETECTION
-- ============================================================================
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.ps1", "*.psm1", "*.psd1" },
  callback = function()
    vim.bo.filetype = "ps1"
  end,
})

-- ============================================================================
-- 4. POWERSHELL SYNTAX OPTIONS (vim-ps1)
-- ============================================================================
-- Uncomment if you want to change folding behavior.
-- vim.g.ps1_nofold_blocks = 1
-- vim.g.ps1_nofold_sig = 1

-- ============================================================================
-- 5. POWERSHELL EDITOR SERVICES (native LSP)
-- ============================================================================
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
end

vim.lsp.config("powershell_es", {
  bundle_path = ps_bundle_path,
  shell = "pwsh",
  on_attach = on_attach,
  settings = {
    powershell = {
      codeFormatting = { Preset = "OTBS" },
    },
  },
})

vim.lsp.enable("powershell_es")

-- Add :LspInfo command for verifying LSP is attached
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    print("No LSP clients attached to this buffer.")
    return
  end

  for _, client in ipairs(clients) do
    print(string.format("%s (id=%d)", client.name, client.id))
  end
end, {})

-- ============================================================================
-- 6. REUSABLE TERMINAL SPLIT
-- ============================================================================
local ps_term_buf = nil
local ps_term_job = nil

local function open_ps_term()
  if ps_term_buf and vim.api.nvim_buf_is_valid(ps_term_buf) then
    local winid = vim.fn.bufwinid(ps_term_buf)
    if winid ~= -1 then
      vim.api.nvim_set_current_win(winid)
    else
      vim.cmd("botright 15split")
      vim.api.nvim_set_current_buf(ps_term_buf)
    end
    return
  end

  vim.cmd("botright 15split")
  vim.cmd("terminal pwsh -NoLogo -NoProfile -NonInteractive")

  ps_term_buf = vim.api.nvim_get_current_buf()
  ps_term_job = vim.b.terminal_job_id

  vim.cmd("startinsert")
end

local function send_to_ps(text)
  open_ps_term()
  if not ps_term_job then
    return
  end
  vim.fn.chansend(ps_term_job, text .. "\r")
end

local function run_current_file()
  vim.cmd("write")
  local file = vim.fn.expand("%:p")
  send_to_ps('& "' .. file .. '"')
end

local function run_selection()
  local save_reg = vim.fn.getreg('"')
  local save_regtype = vim.fn.getregtype('"')

  vim.cmd('normal! "zy')

  local text = vim.fn.getreg("z")
  vim.fn.setreg('"', save_reg, save_regtype)

  if text == "" then
    return
  end

  send_to_ps(text)
end

-- ============================================================================
-- 7. KEY MAPPINGS
-- ============================================================================
vim.keymap.set("n", "<leader>ot", open_ps_term, { desc = "Open PowerShell terminal" })
vim.keymap.set("n", "<leader>rf", run_current_file, { desc = "Run current PS1 file" })
vim.keymap.set("v", "<leader>rs", run_selection, { desc = "Run visual selection" })
