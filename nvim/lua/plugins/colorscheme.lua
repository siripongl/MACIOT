-- =====================================================
-- tokyonight.nvim: color scheme หลักของ config นี้
-- priority = 1000 ทำให้โหลดก่อน plugin อื่น (สีพื้นหลังของ LSP ทุกอย่างถูกตั้งช่วงต้น)
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ tokyonight
return {
  "folke/tokyonight.nvim",
  -- priority สูง เพื่อให้ธีมโหลดก่อน plugins อื่นที่ต้องการใช้สี
  priority = 1000,
  -- config: ตั้งค่าและเปิดใช้ธีม
  config = function()
    -- ชุดสีพื้นหลัง (ปรับแต่งเฉพาะตัวของเจ้าของ config)
    local bg = "#011628"
    local bg_dark = "#011423"
    local bg_highlight = "#143652"
    local bg_search = "#0A64AC"
    local bg_visual = "#275378"
    -- ชุดสีข้อความ (foreground)
    local fg = "#CBE0F0"
    local fg_dark = "#B4D0E9"
    local fg_gutter = "#627E97"
    -- สีขอบ (border) ของหน้าต่างลอยตัว/ป็อปอัป
    local border = "#547998"

    -- เรียก setup ของ tokyonight
    require("tokyonight").setup({
      -- เลือกสไตล์ night (เข้ม ฟ้าน้ำเงิน)
      style = "night",
      -- on_colors ใช้เขียนทับค่าสีของธีม ตามตัวแปรที่นิยามไว้ด้านบน
      on_colors = function(colors)
        colors.bg = bg
        colors.bg_dark = bg_dark
        colors.bg_float = bg_dark
        -- FIXED: แก้คำผิดจาก bg_hightlight เป็น bg_highlight (เดิมเป็น nil ทำให้สีไม่ถูกตั้งค่า)
        colors.bg_highlight = bg_highlight
        colors.bg_popup = bg_dark
        colors.bg_search = bg_search
        colors.bg_sidebar = bg_dark
        colors.bg_statusline = bg_dark
        colors.bg_visual = bg_visual
        colors.border = border
        colors.fg = fg
        colors.fg_dark = fg_dark
        colors.fg_float = fg
        colors.fg_gutter = fg_gutter
        colors.fg_sidebar = fg_dark
      end,
    })

    -- สั่งจริงให้ Neovim ใช้ธีม tokyonight
    vim.cmd("colorscheme tokyonight")
  end,
}
