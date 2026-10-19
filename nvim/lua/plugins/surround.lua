-- =====================================================
-- nvim-surround: จัดการเครื่องหมายครอบรอบข้อความ (เพิ่ม/แก้/ลบ) เช่น ys, ds, cs
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ nvim-surround
return {
  "kylechui/nvim-surround",
  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },
  -- ใช้เวอร์ชัน stable ล่าสุด (tag release)
  version = "*",
  -- config = true: ให้ lazy.nvim เรียก setup() ด้วยค่า default อัตโนมัติ (ไม่ต้องเขียน config)
  config = true,
}
