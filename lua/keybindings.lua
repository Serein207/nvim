vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- to normal
map("i", "jj", "<Esc>", opt)
map("i", "<A-n>", "<Esc>", opt)
map("v", "<A-n>", "<Esc>", opt)
-- 取消 s 默认功能
map("n", "s", "", opt)
-- 分屏快捷键
map("n", "sv", "<C-w>s", opt)
map("n", "sh", "<C-w>v", opt)
-- 关闭当前laga
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "<leader>t", ":ToggleTerm<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("n", "tf", ":ToggleTerm direction=float<CR>", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- normal 模式下，插入新的一行
map("n", "<leader>o", "o<ESC>", opt)
map("n", "<leader>O", "O<ESC>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- Telescope
-- 查找文件
map("n", "<leader><leader>p", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<leader><leader>f", ":Telescope live_grep<CR>", opt)
-- 查找文件（仅包含 CMake 目标所直接包含的源和头文件）
map("n", "<leader>L", "<cmd>Telescope cmake_tools sources initial_mode=insert<CR>", opt)
-- project 
map("n", "<leader>pp", ":Telescope projects<CR>", opt)
-- message
map("n", "<leader>m", ":Telescope notify<CR>", opt)

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- nvim-dap
map("n", "<leader>bb", ":GoBreakToggle<CR>", opt)
map("n", "<leader>dd", ":GoDebug<CR>", opt)
map("n", "<leader>de", ":GoDebug -s<CR>", opt)

-- leap
map("n", "<leader>s", "<Plug>(leap)", opt)
map("n", "S", "<Plug>(leap-backward)", opt)
map("n", "gs", "<Plug>(leap-from-window)", opt)

map("n", "<leader>f", ":lua vim.lsp.buf.format { async = true }<CR>", opt)

vim.keymap.set(
	{ "v", "n", "i", "t" },
	"<F5>",
	"<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>",
	{ silent = true }
)
vim.keymap.set(
	{ "v", "n", "i", "t" },
	"<F17>",
	"<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStopRunner')|call execute('CMakeStopExecutor')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>",
	{ silent = true }
)

-- 插件快捷键
local pluginKeys = {}

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

-- 列表快捷键
pluginKeys.nvimTreeList = {
	-- 打开文件或文件夹
	{ key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
	-- 分屏打开文件
	{ key = "<C-v>", action = "split" },
	-- 显示隐藏文件
	{ key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
	{ key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
	-- 文件操作
	{ key = "<F5>", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "s", action = "system_open" },
}
-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	-- rename
	mapbuf("n", "<leader>r", ":Lspsaga rename<CR>", opt)
	-- code action
	mapbuf("n", "<leader>ca", ":Lspsaga code_action<CR>", opt)
	-- go xx
	mapbuf("n", "gd", ":Lspsaga goto_definition<CR>", opt)
	mapbuf("n", "gh", ":Lspsaga hover_doc<CR>", opt)
	mapbuf("n", "gf", ":Lspsaga finder def+ref<CR>", opt)
	mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
	-- diagnostic
	mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
	mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
	mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)

	-- 没用到
	mapbuf("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opt)
	-- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
	-- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
	-- mapbuf("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
end

return pluginKeys