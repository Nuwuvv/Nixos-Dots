{ config, pkgs, ... }:
{
 programs.neovim = {
   enable = true;
   defaultEditor = true;
   vimAlias = true;
   viAlias = true;
   vimdiffAlias = true;
   extraLuaConfig = ''
       --  Enable Relative numbers
       vim.opt.number = true
       vim.opt.relativenumber = true

       -- cat colors :)
       vim.cmd.colorscheme "catppuccin-mocha"

       -- 2 Space indents for added kawaii *_*
       vim.opt.tabstop = 2
       vim.opt.softtabstop = 2
       vim.opt.shiftwidth = 2
       vim.opt.expandtab = true

       -- Undobackups
       vim.opt.undodir = ".vim/undodir"
       vim.opt.undofile = true

       -- move highlighted stuff with J and K
       vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
       vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

       -- Auto center when using Ctrl-d and Ctrl-u
       vim.keymap.set("n", "<C-d>", "<C-d>zz")
       vim.keymap.set("n", "<C-u>", "<C-u>zz")

       -- Auto center when searching
       vim.keymap.set("n", "n", "nzzzv")
       vim.keymap.set("n", "N", "Nzzzv")

       -- Leader p when pasting over highlighted deletes highlited text into void dir
       vim.keymap.set("x", "<leader>p", "\"_dP")

       -- yank to clipboard with leader remap
       vim.keymap.set("n", "<leader>y", "\"+y")
       vim.keymap.set("v", "<leader>y", "\"+y")
       vim.keymap.set("n", "<leader>Y", "\"+Y")
       
       -- Capital Q big bad
       vim.keymap.set("n", "Q", "<nop>")

       -- Enable mouse mode
       vim.opt.mouse = 'a'

       -- Don't show the mode, redundant
       vim.opt.showmode = false

       -- Enable break indent
       vim.opt.breakindent = true

       -- Save undo history
       vim.opt.undofile = true

       -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
       vim.opt.ignorecase = true
       vim.opt.smartcase = true

       -- Keep signcolumn on by default
       vim.opt.signcolumn = 'auto'

       -- Decrease update time
       vim.opt.updatetime = 250

       -- Decrease mapped sequence wait time
       vim.opt.timeoutlen = 300

       -- Show which line your cursor is on
       vim.opt.cursorline = true

       -- Minimal number of screen lines to keep above and below the cursor.
       vim.opt.scrolloff = 10

       -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
       -- instead raise a dialog asking if you wish to save the current file(s)
       -- See `:help 'confirm'`
       vim.opt.confirm = true

       -- Clear highlights on search when pressing <Esc> in normal mode
       vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

       -- Diagnostic keymaps
       vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

       vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

       -- Disable arrowkeys in normal mode.

       vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
       vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
       vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
       vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

       -- [[ Basic Autocommands ]]

       -- Highlight when yanking (copying) text
       vim.api.nvim_create_autocmd('TextYankPost', {
         desc = 'Highlight when yanking (copying) text',
         group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
         callback = function()
         vim.hl.on_yank()
         end,
       })
     '';
   plugins = with pkgs.vimPlugins; [
     transparent-nvim
     nvim-treesitter
     lsp-zero-nvim
     catppuccin-nvim
     
     (nvim-treesitter.withPlugins (p: [
       p.tree-sitter-nix
       p.tree-sitter-vim
       p.tree-sitter-bash
       p.tree-sitter-lua
       p.tree-sitter-python
       p.tree-sitter-json
     ]))

     vim-nix
   ];
 };
}
