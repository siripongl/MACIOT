-- =====================================================
-- ตัวกลาง (core) ของ Neovim config
-- โหลดค่าตั้งต้นของ Neovim (options) และคีย์แมปพื้นฐาน (keymaps)
-- ไฟล์นี้ถูกเรียกจาก init.lua (บรรทัดแรก: require("core"))
-- -----------------------------------------------------
-- โหลดค่าเริ่มต้นของ Neovim เช่น แท็บ/อินเดนต์, การค้นหา, คลิปบอร์ด
require("core.options")

-- โหลดคีย์แมปพื้นฐาน เช่น leader, การแยกหน้าต่าง, แท็บตั้งค่า
require("core.keymaps")

--NOTE: 2026-9-15
-- ติดตั้ง brew install tree-sitter-cli
-- ติดตั้ง brew install npm
--
-- :Telescope lsp_definitions กระโดดไปยังไฟล์ที่เลือก
-- กดย้อนกลับด้วยการกด Conrol+o
--
--การ redo ให้อยู่ใน command mode แล้วกด control-r
--การ undo ให้อยู่ใน command mode แล้วกด u
--การ clear high ligh ที่เรากด search กด space bar n h
--
--
--
