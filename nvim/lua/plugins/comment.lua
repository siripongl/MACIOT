-- =====================================================
-- Comment.nvim: สลับการคอมเมนต์โค้ดด้วย gcc / gc
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ Comment.nvim
return {
  "numToStr/Comment.nvim",
  -- โหลดเมื่อเปิดอ่านไฟล์ (อ่านครั้งแรก/สร้างไฟล์ใหม่)
  event = { "BufReadPre", "BufNewFile" },
  -- พลักอินช่วยเลือกเครื่องหมายคอมเมนต์ (commentstring) ตามบริบทของภาษา
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  -- config: ตั้งค่าพลักอิน
  config = function()
    -- import comment plugin safely
    -- ดึงตัว Comment มาใช้
    local comment = require("Comment")

    -- ดึง integration ของ ts-context-commentstring มาใช้กับ Comment
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      -- ใช้ treesitter เลือกคอมเมนต์ให้ถูกตำแหน่ง เช่น คอมเมนต์ใน JSX เป็น {/* */} หากจำเป็น
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
