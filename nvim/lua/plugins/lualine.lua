-- =====================================================
-- lualine.nvim: statusline (แถบสถานะ) แบบกำหนดเอง พร้อมธีมสีส่วนตัว
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ lualine
return {
  "nvim-lualine/lualine.nvim",

  -- ใช้ไอคอนไฟล์จาก nvim-web-devicons
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  -- config: ตั้งค่าพลักอิน
  config = function()
    -- ดึงตัว lualine มาใช้
    local lualine = require("lualine")
    -- ดึงสถานะการอัปเดต plugins จาก lazy.nvim (เพื่อโชว์ในแถบสถานะ)
    local lazy_status = require("lazy.status")

    -- ชุดสีที่กำหนดเอง (palette ส่วนตัว)
    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      red = "#FF4A4A",
      yellow = "#FFDA7B",
      orange = "#FF9E64",

      fg = "#C3CCDC",
      bg = "#112638",
      inactive_bg = "#2C3043",
      semilightgray = "#6B7089",
    }

    -- ธีม lualine ส่วนตัว: แต่ละโหมด (normal/insert/visual/...) มีรูปแบบ a/b/c ของตัวเอง
    local my_lualine_theme = {
      -- โหมด normal: ส่วน a (มุมซ้าย) เป็นฟ้า พับตัวหนา
      normal = {
        a = {
          bg = colors.blue,
          fg = colors.bg,
          gui = "bold",
        },
        b = {
          bg = colors.bg,
          fg = colors.fg,
        },
        c = {
          bg = colors.bg,
          fg = colors.fg,
        },
      },

      -- โหมด insert: ส่วน a เป็นเขียว
      insert = {
        a = {
          bg = colors.green,
          fg = colors.bg,
          gui = "bold",
        },
        b = {
          bg = colors.bg,
          fg = colors.fg,
        },
        c = {
          bg = colors.bg,
          fg = colors.fg,
        },
      },

      -- โหมด visual: ส่วน a เป็นม่วง
      visual = {
        a = {
          bg = colors.violet,
          fg = colors.bg,
          gui = "bold",
        },
        b = {
          bg = colors.bg,
          fg = colors.fg,
        },
        c = {
          bg = colors.bg,
          fg = colors.fg,
        },
      },

      -- โหมด command: ส่วน a เป็นเหลือง
      command = {
        a = {
          bg = colors.yellow,
          fg = colors.bg,
          gui = "bold",
        },
        b = {
          bg = colors.bg,
          fg = colors.fg,
        },
        c = {
          bg = colors.bg,
          fg = colors.fg,
        },
      },

      -- โหมด replace: ส่วน a เป็นแดง
      replace = {
        a = {
          bg = colors.red,
          fg = colors.bg,
          gui = "bold",
        },
        b = {
          bg = colors.bg,
          fg = colors.fg,
        },
        c = {
          bg = colors.bg,
          fg = colors.fg,
        },
      },

      -- บัฟเฟอร์ไม่แอ็กทีฟ (หน้าต่างที่ไม่ได้โฟกัส): ใช้สีหมอง
      inactive = {
        a = {
          bg = colors.inactive_bg,
          fg = colors.semilightgray,
          gui = "bold",
        },
        b = {
          bg = colors.inactive_bg,
          fg = colors.semilightgray,
        },
        c = {
          bg = colors.inactive_bg,
          fg = colors.semilightgray,
        },
      },
    }

    lualine.setup({
      options = {
        -- ใช้ธีมที่ออกแบบเองด้านบน
        theme = my_lualine_theme,
      },

      sections = {
        -- ปรับเฉพาะส่วน lualine_x (ทางขวา) ให้เพิ่มข้อมูลพิเศษ
        lualine_x = {
          -- แสดงจำนวน plugins ที่มีเวอร์ชันใหม่ (เป็นสีส้ม) เฉพาะเมื่อมีอัปเดต
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = {
              fg = colors.orange,
            },
          },

          -- แสดง encoding ของไฟล์
          "encoding",
          -- แสดงรูปแบบบรรทัดใหม่ (Unix/DOS/Mac)
          "fileformat",
          -- แสดงชนิดไฟล์ (filetype)
          "filetype",
        },
      },
    })
  end,
}
