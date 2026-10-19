-- =====================================================
-- alpha-nvim: หน้า dashboard / start screen พร้อมปุ่มลัด
-- โหลดเมื่อเข้าโปรแกรม (VimEnter) ก่อนเปิดไฟล์อื่น
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ alpha-nvim
return {
  "goolord/alpha-nvim",
  -- โหลด plugin เมื่อเกิด event VimEnter (ชี้ว่า Neovim เริ่มต้นเสร็จแล้ว)
  event = "VimEnter",

  -- config: ฟังก์ชันที่ lazy.nvim เรียกเพื่อตั้งค่า plugin
  config = function()
    -- ดึงตัว alpha หลักมาใช้
    local alpha = require("alpha")
    -- ดึงธีม dashboard (มี section header, buttons, footer ให้แล้ว)
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    -- section.header.val เก็บข้อความ ASCII art เพื่อแสดงส่วนหัว
    dashboard.section.header.val = {
      "                                                ",
      "███╗   ███╗ █████╗  ██████╗██╗ ██████╗ ████████╗",
      "████╗ ████║██╔══██╗██╔════╝██║██╔═══██╗╚══██╔══╝",
      "██╔████╔██║███████║██║     ██║██║   ██║   ██║   ",
      "██║╚██╔╝██║██╔══██║██║     ██║██║   ██║   ██║   ",
      "██║ ╚═╝ ██║██║  ██║╚██████╗██║╚██████╔╝   ██║   ",
      "╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝ ╚═════╝    ╚═╝   ",
      "                                                ",
    }

    -- Set menu
    -- section.buttons.val เก็บรายการปุ่มลัดที่แสดงใต้ header
    -- รูปแบบ: dashboard.button(คีย์ที่กด, ข้อความ, คำสั่งที่รัน)
    dashboard.section.buttons.val = {
      -- e: สร้างไฟล์ใหม่
      dashboard.button("e", "  > New File", "<cmd>enew<CR>"),
      -- SPC ee: เปิด/ปิด file explorer (nvim-tree)
      dashboard.button("SPC ee", "  > Toggle File Explorer", "<cmd>NvimTreeToggle<CR>"),
      -- SPC ff: ค้นหาไฟล์ด้วย Telescope
      dashboard.button("SPC ff", "󰈞  > Find File", "<cmd>Telescope find_files<CR>"),
      -- SPC fs: ค้นหาข้อความในไฟล์ (live grep)
      dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
      -- q: ออกจากโปรแกรม
      dashboard.button("q", "󰗼  > Quit Nvim", "<cmd>qa<CR>"),
    }

    -- Send config to alpha
    -- เรียก setup ของ alpha โดยใช้ opts ของธีม dashboard
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    -- ปีดการพับโค้ด (folding) ในบัฟเฟอร์ alpha เพื่อให้ข้อความแสดงเต็มบรรทัด
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
  end,
}
