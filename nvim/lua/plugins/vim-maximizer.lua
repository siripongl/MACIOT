-- =====================================================
-- vim-maximizer: สลับขยายหน้าต่าง split ปัจจุบันให้เต็มจอ (แล้วกลับเท่าเดิม)
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ vim-maximizer
return {
  "szw/vim-maximizer",
  -- keys: กดแล้วโหลด plugin ทันที (lazy loading ผ่านคีย์แมป)
  keys = {
    {
      -- <space>sm: ขยาย/ย่อขนาดหน้าต่าง split ปัจจุบัน
      "<leader>sm",
      "<cmd>MaximizerToggle<CR>",
      desc = "Maximize/minimize a split",
    },
  },
}
