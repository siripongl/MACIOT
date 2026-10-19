-- =====================================================
-- ตั้งค่า options ของ Neovim ทั้งหมด (ตัวแม่แบบ vim.opt)
-- -----------------------------------------------------
-- เรียกใช้คำสั่ง VimScript ให้ Netrw แสดงไฟล์แบบ tree (g:netrw_liststyle = 3)
vim.cmd("let g:netrw_liststyle = 3") --make :Explo Change

-- ตัวย่อสำหรับ vim.opt เพื่อเขียนสั้นลง (opt.number = ...)
local opt = vim.opt

-- แสดงหมายเลขบรรทัดแบบ relative (นับขอจากบรรทัดปัจจุบัน)
opt.relativenumber = true

-- แสดงหมายเลขบรรทัดจริงด้วย (โหมด normal / insert)
opt.number = true

--tabs & indentation
-- กำหนดความกว้างของ 1 tab = 2 ช่องว่าง
opt.tabstop = 2

-- จำนวนช่องว่างที่ใช้เมื่อกด indent (>>, <<) = 2 ช่อง
opt.shiftwidth = 2

-- กด Tab แล้วแทรกช่องว่างแทนอักขระ tab จริง
opt.expandtab = true

-- เปิด autoindent: บรรทัดใหม่จะเป็นไปตาแนวบรรทัดก่อนหน้า
opt.autoindent = true

-- ปิดการตัดบรรทัด (wrap) ให้บรรทัดยาวยื่นไปทางด้านขวาแทน
opt.wrap = false

--search settings
-- ค้นหาโดยไม่สนใจตัวพิมพ์เล็กใหญ่
opt.ignorecase = true --ignore case when searching

-- แต่ถ้าพิมพ์ค้นหามีตัวพิมพ์ใหญ่ จะถือว่าเป็น case-sensitive
opt.smartcase = true --if you include mixed case in you search, assumes you want case-sensitive

-- ปิดไฮไลต์บรรทัดที่เคอร์เซอร์อยู่ (cursorline)
opt.cursorline = false

-- เปิดใช้ 24-bit true colors (จำเป็นสำหรับ color scheme แบบ tokyonight)
opt.termguicolors = true

-- ธีม default เป็นแบบมืด
opt.background = "dark"

-- แสดงคอลัมน์ signcolumn เสมอ (กัน layout ขยับเมื่อมี git/LSP sign)
opt.signcolumn = "yes"

--backspace
-- ให้ปุ่ม backspace ลบได้ทั้ง indent, ท้ายบรรทัด และย้อนจุดเริ่มโหมด insert
opt.backspace = "indent,eol,start" --allow backspace on indent, end of line or insert mode start position

--clipboard
-- ผูก clipboard กับระบบของ macOS: copy/paste ข้ามแอปได้เลย
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

--split windows
-- เปิดหน้าต่างแนวตั้งทางด้านขวาเสมอ (vsplit)
opt.splitright = true -- split vertical windows to the right

-- เปิดหน้าต่างแนวนอนทางด้านล่างเสมอ (split)
opt.splitbelow = true -- split horizontal windows to the bottom

-- =====================================================
-- Session
-- =====================================================

-- ให้ Neovim บันทึก local options ลงใน session
opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
  "localoptions",
}
