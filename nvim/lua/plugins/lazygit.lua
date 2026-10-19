-- =====================================================
-- lazygit.nvim: เปิด lazygit (Git TUI) จากภายใน Neovim
-- NOTE: ต้องติดตั้งตัว lazygit เองแยก (brew install lazygit) — Mason ไม่ได้ติดตั้งให้
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ lazygit
return {
  "kdheepak/lazygit.nvim",
  -- โหลดเฉพาะเมื่อเรียกคำสั่ง (command) เหล่านี้ ไม่โหลดตอนเริ่มต้น
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },

  -- ต้องใช้ plenary.nvim ในการรันคำสั่ง lazygit
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- key: กด <space>lg เพื่อเปิด lazygit (โหลด plugin ทันทีตอนกด)
  key = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
  },
}
