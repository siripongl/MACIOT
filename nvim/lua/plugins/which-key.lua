-- =====================================================
-- which-key.nvim: แสดงป๊อปอัปรายการคีย์แมปที่ขึ้นต้นด้วย <leader>/prefix ที่กด
-- เช่น กด Space ค้าง แล้วเห็นคำสั่งทั้งหมดที่ใช้ <space>...
-- -----------------------------------------------------
--เพิ่มตัวอย่างหลังกด spacebar จะสามารดดูคำสังที่เราสามารถใช้งานได้

-- คืนค่าสเปกของ lazy.nvim สำหรับ which-key
return {
  "folke/which-key.nvim",
  -- โหลดหลังการตั้งค่าพื้นฐานเสร็จ (VeryLazy - ช้าเพื่อไม่ให้เสียเวลาเริ่มต้น)
  event = "VeryLazy",
  -- init ทำงานก่อน plugin โหลดจริง (เตรียมค่า timeout สำหรับการกดคีย์ผสม)
  init = function()
    -- เปิด timeout เมื่อรอคีย์ถัดไป (จำเป็นสำหรับคีย์ผสมแบบ <leader>xx)
    vim.o.timeout = true
    -- รอรับคีย์ถัดไปได้นานสุด 1s ก่อนถือว่ายกเลิก
    vim.o.timeoutlen = 1000
  end,
  -- FIXED: เดิมใช้ `opt` (lazy.nvim ไม่อ่าน field นี้) ทำให้ setup() ไม่ถูกเรียก
  -- จึงไม่มี effect เลย เปลี่ยนเป็น `opts` เพื่อให้ lazy.nvim เรียก setup() อัตโนมัติ
  opts = {
    --your configuration comes here
    --or leace it empty to use the default setting
    --refer to the configuration section below
  },
}
