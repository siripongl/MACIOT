-- =====================================================
-- nvim-autopairs: เปิด/ปิดวงเล็บและเครื่องหมายครอบให้อัตโนมัติ
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ nvim-autopairs
return {
  "windwp/nvim-autopairs",
  -- โหลดเมื่อเริ่มพิมพ์ (เข้าโหมด insert) เพื่อลดเวลาเริ่มต้น
  event = { "InsertEnter" },
  -- ต้องใช้ nvim-cmp เพื่อเชื่อมต่อ auto-complete ให้เข้ากับวงเล็บอัตโนมัติ
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  -- config: ตั้งค่าพลักอิน
  config = function()
    -- import nvim-autopairs
    -- ดึงตัว autopairs มาใช้
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      -- เปิดใช้ treesitter ในการตรวจสอบว่าจะใส่วงเล็บหรือไม่
      check_ts = true, --enable treesitter
      ts_config = {
        -- ไม่เพิ่มเครื่องหมายครอบในโหนด string ของ Lua (เช่น "..." ที่พิมพ์เอง)
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        -- ไม่เพิ่มเครื่องหมายครอบใน template_string ของ JS/TS (เช่น `${...}`)
        javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
        -- ไม่ใช้ treesitter ตรวจสอบใน Java
        java = false, -- don't check treesitter on java
      },
    })

    -- import nvim-autopairs completion functionality
    -- ดึงฟังก์ชันให้ autopairs ทำงานร่วมกับระบบ completion ของ nvim-cmp
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- import nvim-cmp plugin (completions plugin)
    -- ดึงตัว nvim-cmp มาใช้
    local cmp = require("cmp")

    -- make autopairs and completion work together
    -- เมื่อยืนยันการเลือก completion ให้ autopairs เติมวงเล็บปิดให้อัตโนมัติ
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
