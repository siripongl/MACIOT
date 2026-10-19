-- =====================================================
-- indent-blankline.nvim: วาดเส้นแสดงระดับการเยื้อง (indent guide)
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ indent-blankline
return {
  "lukas-reineke/indent-blankline.nvim",
  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },
  -- main = "ibl": ชี้ว่าโมดูลหลักของ plugin คือ ibl (ใช้ require("ibl") ไม่ใช่ indent_blankline)
  main = "ibl",
  -- opts: lazy.nvim เรียก setup() อัตโนมัติด้วยตารางนี้
  opts = {
    -- ใช้ตัวอักษร "┊" วาดเส้นแนวตั้งของ indent
    indent = { char = "┊" },
  },
}
