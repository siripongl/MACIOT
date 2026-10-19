-- =====================================================
-- trouble.nvim: แสดง diagnostics / quickfix / loclist / TODO เป็นรายการข้างข้าง
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ trouble
return {
  "folke/trouble.nvim",

  -- FIXED: เดิมไม่มี opts ทำให้ setup() ไม่ถูกเรียก -> คำสั่ง :Trouble ไม่มีอยู่จริง
  -- opts = {} ทำให้ lazy.nvim เรียก setup() ด้วยค่า default อัตโนมัติ
  opts = {},

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },

  -- keys: คีย์แมปเพื่อเปิด/สลับช่องรายการ
  keys = {
    -- <space>xx: สลับเปิด/ปิด diagnostics (ทุกบัฟเฟอร์)
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<CR>",
      desc = "Diagnostics",
    },
    -- <space>xw: เปิด diagnostics ระดับ workspace (ทั้งโฟลเดอร์)
    {
      "<leader>xw",
      "<cmd>Trouble diagnostics toggle<CR>",
      desc = "Workspace diagnostics",
    },
    -- <space>xd: เปิด diagnostics เฉพาะบัฟเฟอร์ปัจจุบัน
    {
      "<leader>xd",
      "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Document diagnostics",
    },
    -- <space>xq: เปิด quickfix list
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<CR>",
      desc = "Quickfix list",
    },
    -- <space>xl: เปิด location list
    {
      "<leader>xl",
      "<cmd>Trouble loclist toggle<CR>",
      desc = "Location list",
    },
    -- <space>xt: เปิดรายการ TODO comments
    {
      "<leader>xt",
      "<cmd>Trouble todo toggle<CR>",
      desc = "TODO comments",
    },
  },
}
