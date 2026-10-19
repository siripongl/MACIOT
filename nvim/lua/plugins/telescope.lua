-- =====================================================
-- telescope.nvim: เฟสซีฟายด์เครื่องมือค้นหา (files, buffers, grep, LSP, git ...)
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ telescope
return {
  "nvim-telescope/telescope.nvim",

  -- โหลดเมื่อเรียกคำสั่ง :Telescope (ไม่โหลดตอนเริ่มต้น)
  cmd = "Telescope",
  -- version = false หมายถึงไม่ล็อกเวอร์ชัน (ติดตั้งจาก branch ล่าสุดเสมอ)
  version = false,

  dependencies = {
    -- fzf-native: เพิ่มความเร็วการกรองโดยใช้ไลบรารี C (ต้องคอมไพล์ด้วย make)
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },

    -- plenary.nvim: ฟังก์ชัน lua พื้นฐานที่ telescope ใช้
    "nvim-lua/plenary.nvim",

    -- trouble.nvim เป็น optional (โหลดด้วยถ้ามี) เผื่อใช้รวมกับ LSP
    {
      "folke/trouble.nvim",
      optional = true,
    },
    -- todo-comments.nvim: ใช้ค้นหา TODO comment ผ่าน telescope
    "folke/todo-comments.nvim",
  },

  -- keys: คีย์แมปทั้งหมดของ telescope (โหลด plugin เฉพาะเมื่อกด)
  keys = {
    -- Find todos
    -- <space>ft: ค้นหา TODO/แก้ป้าย comments ในโปรเจกต์
    {
      "<leader>ft",
      "<cmd>TodoTelescope<cr>",
      desc = "find todos",
    },

    -- Buffers
    -- <space>,: สลับบัฟเฟอร์ (เรียงตามเพิ่งใช้ล่าสุด)
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },

    -- Find
    -- <space>ff: ค้นหาไฟล์ (find_files)
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "Find Files",
    },

    -- <space>fg: ค้นหาเฉพาะไฟล์ใน git
    {
      "<leader>fg",
      "<cmd>Telescope git_files<cr>",
      desc = "Find Git Files",
    },

    -- <space>fr: เปิดไฟล์ที่เพิ่งใช้งาน (oldfiles)
    {
      "<leader>fr",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Recent Files",
    },

    -- <space>fb: รายชื่อบัฟเฟอร์ที่เปิดอยู่
    {
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      desc = "Buffers",
    },

    -- Grep
    -- <space>sg: ค้นหาข้อความ (live grep) ในโปรเจกต์
    {
      "<leader>sg",
      "<cmd>Telescope live_grep<cr>",
      desc = "Grep",
    },

    -- <space>sw: ค้นหาข้อความใต้เคอร์เซอร์ (grep ถ้าพิมพ์ต่อได้)
    {
      "<leader>sw",
      "<cmd>Telescope grep_string<cr>",
      desc = "Search Word",
    },

    -- TODO: Telescope Dupicate with split hollizontal "Comment by Siripong"
    -- Help
    --{
    --  "<leader>sh",
    --  "<cmd>Telescope help_tags<cr>",
    --  desc = "Help Pages",
    --},

    -- Diagnostics
    -- <space>sd: ดู diagnostics ทั้งโปรเจกต์
    {
      "<leader>sd",
      "<cmd>Telescope diagnostics<cr>",
      desc = "Diagnostics",
    },

    -- <space>sD: ดู diagnostics เฉพาะบัฟเฟอร์ปัจจุบัน
    {
      "<leader>sD",
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      desc = "Buffer Diagnostics",
    },

    -- Symbols
    -- <space>ss: แสดงสัญลักษณ์ (ฟังก์ชัน/ตัวแปร) ในไฟล์ปัจจุบัน
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Document Symbols",
    },

    -- <space>sS: แสดงสัญลักษณ์ทั้งเวิร์กสเปซ
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      desc = "Workspace Symbols",
    },

    -- Keymaps
    -- <space>sk: ตรวจสอบคีย์แมปทั้งหมดใน Neovim
    {
      "<leader>sk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Key Maps",
    },

    -- Commands
    -- <space>sc: ประวัติคำสั่งที่พิมพ์ (command history)
    {
      "<leader>sc",
      "<cmd>Telescope command_history<cr>",
      desc = "Command History",
    },

    -- <space>sC: รายชื่อคำสั่ง Ex ทั้งหมด (commands)
    {
      "<leader>sC",
      "<cmd>Telescope commands<cr>",
      desc = "Commands",
    },

    -- Registers
    -- <space>s": ดู/เลือกเนื้อหาใน registers (คลิปบอร์ด)
    {
      '<leader>s"',
      "<cmd>Telescope registers<cr>",
      desc = "Registers",
    },

    -- Git
    -- <space>gc: ประวัติ commits ของ git
    {
      "<leader>gc",
      "<cmd>Telescope git_commits<cr>",
      desc = "Git Commits",
    },

    -- <space>gs: สถานะ git (diff ไฟล์ที่แก้ไข)
    {
      "<leader>gs",
      "<cmd>Telescope git_status<cr>",
      desc = "Git Status",
    },

    -- <space>gS: รายการ git stash
    {
      "<leader>gS",
      "<cmd>Telescope git_stash<cr>",
      desc = "Git Stash",
    },
  },

  -- opts: ตัวเลือก configuration ของ telescope (lazy.nvim ส่งให้ setup)
  opts = {
    defaults = {
      -- สัญลักษณ์หน้า prompt
      prompt_prefix = " ",
      -- สัญลักษณ์บอก row ที่เลือก
      selection_caret = " ",

      -- ปุ่มลัดภายในผลการค้นหา (โหมด insert)
      mappings = {
        i = {
          ["<C-Down>"] = "cycle_history_next",
          ["<C-Up>"] = "cycle_history_prev",
          -- เลื่อนดูตัวอย่างไฟล์ (preview) ลง/ขึ้น
          ["<C-f>"] = "preview_scrolling_down",
          ["<C-b>"] = "preview_scrolling_up",
        },

        -- กด q เพื่อปิดหน้าต่าง telescope (โหมด normal)
        n = {
          ["q"] = "close",
        },
      },
    },

    -- ตั้งค่าเฉพาะ picker (เครื่องมือค้นหา) บางตัว
    pickers = {
      find_files = {
        -- แสดงไฟล์ที่ซ่อนด้วย (hidden files)
        hidden = true,
      },
    },

    -- ตั้งค่า fzf extension
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },

  -- config: ตั้งค่า telescope แล้วโหลด fzf extension
  config = function(_, opts)
    local telescope = require("telescope")

    -- ใช้ opts ที่ให้ไว้ด้านบน
    telescope.setup(opts)

    -- โหลด fzf extension แบบปลอดภัย (ไม่ error ถ้าไม่ติดตั้งสำเร็จ)
    pcall(telescope.load_extension, "fzf")
  end,
}
