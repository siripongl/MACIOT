-- =====================================================
-- คีย์แมปพื้นฐาน (global) ของ Neovim
-- -----------------------------------------------------
-- กำหนด leader key เป็น Space (ใช้ <leader>xx ในคีย์แมปอื่น ๆ)
vim.g.mapleader = " "

-- ตัวย่อ vim.keymap เพื่อเขียนให้สั้นลง
local keymap = vim.keymap -- for conciseess

-- กด jk พร้อมกันในโหมด insert เพื่อออกไปโหมด normal
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- กด <space>nh เพื่อปิดไฮไลต์ผลการค้นหา (nohlsearch)
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--increment/decrement number
-- กด <space>+ เพื่อเพิ่มค่าตัวเลขใต้เคอร์เซอร์ (+1)
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment

-- กด <space>- เพื่อลดค่าตัวเลขใต้เคอร์เซอร์ (-1)
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

--window management
-- กด <space>sv เพื่อแยกหน้าต่างแนวตั้ง (ไปทางขวา ตาม setting splitright)
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window verically" }) -- split window vertically

-- กด <space>sh เพื่อแยกหน้าต่างแนวนอน (ลงล่าง ตาม setting splitbelow)
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizaontally" }) -- split window horizontal

-- กด <space>se เพื่อปรับทุกหน้าต่างให้มีขนาดเท่ากัน
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal windows

-- กด <space>sx เพื่อปิดหน้าต่างปัจจุบัน
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split windows

-- กด <space>to เพื่อสร้างแท็บใหม่
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- Open new tab

-- กด <space>tx เพื่อปิดแท็บปัจจุบัน
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- Close current tab

-- กด <space>tn เพื่อไปแท็บถัดไป
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to new tab" }) -- go to next tab

-- กด <space>tp เพื่อย้อนกลับแท็บก่อนหน้า
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- go to previous tab

-- กด <space>gd
keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP Go to Definition " })

-- -- กด <space>gd
-- keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP Go to References " })

-- กด <space>tf เพื่อเปิดไฟล์ปัจจุบันในแท็บใหม่
--NOTE: Config นี้ชนกัน
--keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --
