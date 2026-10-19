-- =====================================================
-- รายชื่อ plugins ที่เป็น dependency ร่วมกัน (ตัวช่วยพื้นฐาน)
-- ไฟล์นี้เป็น spec list ที่ lazy.nvim import เข้ามาโดยอัตโนมัติผ่าน { import = "plugins" }
-- ไม่ใช่ "main entry" ไม่ได้เรียก load ไฟล์อื่นในโฟลเดอร์ plugins
-- -----------------------------------------------------
-- คืนค่าตาราง (table) ที่เป็นรายการ plugins สำหรับ lazy.nvim
return {
  -- plenary.nvim: ชุดฟังก์ชัน lua ที่ plugins หลายตัวใช้ร่วมกัน (ต้องโหลดก่อนเสมอ)
  "nvim-lua/plenary.nvim", --lua functions that many plugins use

  -- vim-tmux-navigator: กด ctrl+hjkl เพื่อย้ายระหว่าง split กับ tmux pane ได้
  "christoomey/vim-tmux-navigator", --tmux & split window navigation
}
