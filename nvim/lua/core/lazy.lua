-- =====================================================
-- โหลดและตั้งค่า lazy.nvim (ตัวจัดการ plugins)
-- บูตสแตรป: ติดตั้ง lazy.nvim เองครั้งแรก แล้วโหลด spec ทั้งหมด
-- -----------------------------------------------------
-- ตำแหน่งเก็บ lazy.nvim ใน data directory ของ Neovim (~/.local/share/nvim/lazy/lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- ถ้ายังไม่เคยติดตั้ง lazy.nvim (ตรวจสอบว่ามีโฟลเดอร์หรือยัง)
if not vim.loop.fs_stat(lazypath) then
  -- ใช้ git clone แบบ blob:none (โหลดเฉพาะประวัติเวอร์ชันล่าสุด) เข้ามา
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- เพิ่ม lazy.nvim เข้า runtimepath เพื่อให้ require("lazy") ใช้งานได้
vim.opt.rtp:prepend(lazypath)

-- ตั้งค่า lazy.nvim: ระบุให้ import specs ทั้งหมดจากโฟลเดอร์ "plugins" และ "plugins.lsp"
require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.lsp" },
  -- ตรวจสอบเวอร์ชันใหม่ของ plugins เป็นระยะ (ไม่แจ้งเตือนให้รำคาญ)
  checker = {
    enabled = true,
    notify = false,
  },

  -- เมื่อแก้ไขไฟล์ spec เอง จะไม่แจ้งเตือนการเปลี่ยน
  change_detection = {
    notify = false,
  },
})
