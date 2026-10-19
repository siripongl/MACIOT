-- =====================================================
-- substitute.nvim: แทนที่ข้อความแบบ fancier (ใช้ s, ss, S เหมือน vim-sandwich)
-- โดยกด s ก่อนแล้วเลือก motion ว่าต้องการแทนที่อะไร
-- -----------------------------------------------------
-- TODO: This next time don't Use "Comment by Siripong"

-- คืนค่าสเปกของ lazy.nvim สำหรับ substitute
return {
  "gbprod/substitute.nvim",
  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },

  -- config: ตั้งค่าพลักอิน
  config = function()
    -- ดึงตัว substitute มาใช้
    local substitute = require("substitute")

    -- เรียก setup ด้วยค่า default ทั้งหมด
    substitute.setup()

    -- set keymaps
    -- s: แทนที่ด้วย motion (เช่น s iw = แทนที่คำในวงใน)
    vim.keymap.set("n", "s", substitute.operator, {
      desc = "Substitute with motion",
    })

    -- ss: แทนที่ทั้งบรรทัด
    vim.keymap.set("n", "ss", substitute.line, {
      desc = "Substitute line",
    })

    -- S: แทนที่จากตำแหน่งเคอร์เซอร์ถึงท้ายบรรทัด (แทบไม่ใช้ตัว s ต่อท้ายาแทน EOL)
    vim.keymap.set("n", "S", substitute.eol, {
      desc = "Substitute to end of line",
    })

    -- s: (โหมด visual) แทนที่ข้อความที่เลือก
    vim.keymap.set("x", "s", substitute.visual, {
      desc = "Substitute in visual mode",
    })
  end,
}
