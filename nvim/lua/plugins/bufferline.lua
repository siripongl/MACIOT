-- =====================================================
-- bufferline.nvim: แสดงบัฟเฟอร์/แท็บแบบ tab bar ด้านบน
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ bufferline
return {
  "akinsho/bufferline.nvim",
  -- ใช้ไอคอนไฟล์จาก nvim-web-devicons
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- ใช้เวอร์ชัน stable ล่าสุด (version = "*" หมายถึง tag release)
  version = "*",
  -- opts: lazy.nvim เรียก setup() อัตโนมัติด้วยตารางนี้
  opts = {
    options = {
      -- แสดงบัฟเฟอร์เป็นแท็บ (mode = "tabs") แทนการตัดคำ
      mode = "tabs",
      -- ลักษณะตัวคั่นระหว่างแท็บเป็นเส้นเฉียง (slant)
      separator_style = "slant",
    },
  },
}
