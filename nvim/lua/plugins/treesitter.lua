-- =====================================================
-- nvim-treesitter: syntax highlighting และ indentation ตามโครงสร้างภาษา (AST)
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },
  -- build: หลังติดตั้ง/อัปเดต plugin ให้รัน :TSUpdate (ติดตั้ง parser ให้เป็นปัจจุบัน)
  build = ":TSUpdate",
  -- nvim-ts-autotag: ปิด/เปิดแท็ก HTML อัตโนมัติ (เช่น เพิ่ม </div> เอง)
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  -- config: ตั้งค่าพลักอิน
  config = function()
    --import nvim-treesitter plugin
    -- ดึงตัว nvim-treesitter มาใช้
    local treesitter = require("nvim-treesitter")

    --configure treesitter
    treesitter.setup({ --enable sybtax highlighting
      -- เปิด syntax highlighting ตามโครงสร้างภาษา
      highlight = {
        enable = true,
      },
      --enable indentation
      -- เปิด indentation อัตโนมัติตาม treesitter
      indent = { enable = true },
      --enable autotagging (w/nvim-ts-autotag plugin)
      -- เปิด autotag (ปิด/เปิดแท็ก HTML อัตโนมัติ) ร่วมกับ nvim-ts-autotag
      autotag = {
        enable = true,
      },
      --ensure these language parsers are installed
      -- รายชื่อ parser (ตัวแยกโครงสร้างภาษา) ที่ให้ติดตั้งอัตโนมัติ
      ensure_installed = {
        "lua",
        "vim",
        "bash",
        "c",
        "c++",
        "cpp",
        "python",
        "css",
        "html",
        "json",
        "vimdoc",
      },
      -- เลือกช่วงโค้ดแบบเพิ่ม/ลด node (incremental selection)
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
