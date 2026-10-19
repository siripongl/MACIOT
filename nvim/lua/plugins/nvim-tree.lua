-- =====================================================
-- nvim-tree.lua: file explorer (ต้นไม้โฟลเดอร์) ใน Neovim
-- ใช้แทน netrw default + ปิด netrw เพื่อหลีกเลี่ยงความขัดแย้ง
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ nvim-tree
return {
  "nvim-tree/nvim-tree.lua",
  -- ใช้ไอคอนไฟล์จาก nvim-web-devicons
  dependencies = "nvim-tree/nvim-web-devicons",
  -- config: ตั้งค่าพลักอิน
  config = function()
    -- ดึงตัว nvim-tree มาใช้
    local nvimtree = require("nvim-tree")

    --recommended settings from nvim-tree documentation
    -- ปิด netrw (ตัวจัดการไฟล์ดั้งเดิมของ Vim) เพื่อไม่ให้แย่งคีย์กับ nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      -- ดีไซน์หน้าต่าง explorer
      view = {
        -- ความกว้างของ explorer 35 ช่องอักขระ
        width = 35,
        -- แสดงหมายเลขบรรทัดแบบ relative ใน explorer ด้วย
        relativenumber = true,
      },
      --change folder arrow icons
      -- ปรับการแสดงผล node ในแผนผัง
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "→", --arrow when foler is close
              arrow_open = "↓", --arrow when folder is open
            },
          },
        },
      },
      --disable window_picket for
      --explorer to work well with
      --windows splits
      -- ปิด window picker (ตัวเลือกว่าจะเปิดไฟล์ในหน้าต่างไหน)
      -- เพื่อให้ explorer ทำงานเข้ากับการแยกหน้าต่าง (split) ได้ดี
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        -- ซ่อนไฟล์ .DS_Store (ขยะของ macOS) จากการแสดงผล
        custom = { ".DS_Store" },
      },
      git = {
        -- แสดงไฟล์ที่อยู่ใน .gitignore ด้วย (ignore = false)
        ignore = false,
      },
    })

    --setkey maps
    local keymap = vim.keymap -- for conciseness

    -- <space>ee: เปิด/ปิด explorer
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    -- <space>ef: เปิด explorer โดยชี้ที่ไฟล์ปัจจุบัน
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on cursor" })
    -- <space>ec: พับโฟลเดอร์ทั้งหมดใน explorer
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    -- <space>er: รีเฟรช explorer (เช่น หลังสร้าง/ลบไฟล์ข้างนอก)
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end,
}
