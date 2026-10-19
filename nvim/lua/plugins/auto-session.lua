-- =====================================================
-- auto-session: บันทึก / กู้คืน session
-- -----------------------------------------------------
-- บันทึกและกู้คืน window / tab / split
-- แยกตามโฟลเดอร์ของโปรเจกต์
-- =====================================================

return {
  "rmagatti/auto-session",

  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      -- ไม่กู้คืน session อัตโนมัติ
      -- จะกู้คืนเองด้วย <leader>wr
      auto_restore_enable = false,

      -- ไม่สร้าง session ใน directory เหล่านี้
      suppressed_dirs = {
        "~/",
        "~/Dev",
        "~/Downloads",
        "~/Documents",
        "~/Desktop",
      },
    })

    -- ตัวย่อ vim.keymap
    local keymap = vim.keymap

    -- Restore session
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })

    -- Save session
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for cwd" })
  end,
}
