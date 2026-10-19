-- ==================================================================
-- nvim-lspconfig: ตั้งค่า LSP servers ทั้งหมดของ config นี้
-- ----------------------------------------------------------------
-- ใช้ API สมัยใหม่ (Neovim ≥ 0.11): vim.lsp.config() สำหรับตั้งค่า
-- และ vim.lsp.enable() สำหรับเปิดใช้งาน server
-- อย่าเปลี่ยนกลับไปใช้รูปแบบเก่า setup{} / on_attach (จะพัง)
--
-- รายชื่อ server ที่ vim.lsp.enable() ต้องตรงกับ ensure_installed
-- ในไฟล์ mason.lua เสมอ (เพิ่มที่นี่ลืมอีกที่ = server ใช้งานไม่ได้)
-- ==================================================================

return {
  -- ชื่อ plugin หลักที่ lazy.nvim จะติดตั้ง
  "neovim/nvim-lspconfig",

  -- lazy-load: โหลดเฉพาะเมื่อเปิดไฟล์ (ปกติ/สร้างไฟล์ใหม่) เพื่อให้เริ่มเร็ว
  event = { "BufReadPre", "BufNewFile" },

  -- dependencies = plugin ที่ต้องโหลดพร้อมกัน
  dependencies = {
    -- ใช้เติม capabilities ให้ LSP ส่งผลลัพธ์ร่วมกับ nvim-cmp ได้
    "hrsh7th/cmp-nvim-lsp",

    {
      -- จัดการ rename/move ไฟล์อัตโนมัติตามที่ LSP แจ้ง (FileOperations)
      "antosha417/nvim-lsp-file-operations",
      -- ใช้ config แบบ default ของ plugin ตัวนี้
      config = true,
    },

    -- {
    --   -- เพิ่ม type definition ของ Neovim API ให้ lua_ls (เฉพาะตอนเขียน lua)
    --   "folke/neodev.nvim",
    --   -- config = ตั้งค่า neodev ทันทีที่โหลด (ก่อนตั้งค่า lua_ls)
    --   config = function()
    --     -- เปิดใช้งาน neodev ด้วยค่า default (ช่วย auto-complete สำหรับ config)
    --     require("neodev").setup({})
    --   end,
    -- },
  },

  -- config = ฟังก์ชันที่ lazy.nvim เรียกเมื่อโหลด plugin นี้
  config = function()
    -- =============================================================
    -- CMP capabilities
    -- =============================================================

    -- capabilities = ความสามารถของ client LSP (ที่นี่ = ค่า default ของ nvim-cmp)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- =============================================================
    -- Diagnostic display ระดับ global
    -- =============================================================

    -- ตั้งค่ารูปแบบการแสดงผล diagnostics ทั่วทั้ง editor
    vim.diagnostic.config({
      -- ข้อความ virtual_text ต่อท้ายบรรทัด: เว้น 4 ช่อง + แสดงแหล่งที่มาเมื่อหลาย server
      virtual_text = {
        spacing = 4,
        source = "if_many",
      },
      -- แสดงไอคอนที่คอลัมน์ signcolumn
      signs = true,
      -- ขีดเส้นใต้บรรทัดที่มี error
      underline = true,
      -- เก็บ diagnostics เฉพาะเมื่อหยุดพิมพ์ (ไม่อัปเดตระหว่างพิมพ์)
      update_in_insert = false,
      -- เรียง diagnostics ตามความรุนแรง (error ก่อน warn ฯลฯ)
      severity_sort = true,
      -- หน้าต่าง float ของ diagnostics (เช่นจาก <leader>d)
      float = {
        -- ขอบมน
        border = "rounded",
        -- แสดงแหล่งที่มาเมื่อมีหลาย server
        source = "if_many",
      },
    })

    -- =============================================================
    -- Diagnostic icons (แสดงใน signcolumn)
    -- =============================================================

    -- ตารางไอคอนสำหรับแต่ละระดับความรุนแรง (ใช้ Nerd Font)
    local signs = {
      Error = "",
      Warn = "",
      Hint = "󰠠",
      Info = "",
    }

    -- วนลูปกำหนด sign ให้กับทุกประเภท diagnostic
    for type, icon in pairs(signs) do
      -- ชื่อ highlight group ของ sign นั้น (เช่น DiagnosticSignError)
      local hl = "DiagnosticSign" .. type

      -- ลงทะเบียน sign: ใช้ไอคอน + ใช้ highlight group ของ diagnostic
      vim.fn.sign_define(hl, {
        text = icon, -- ไอคอนที่แสดงในคอลัมน์ sign
        texthl = hl, -- สีของไอคอนตามกลุ่ม highlight
        numhl = "", -- ไม่เปลี่ยนสีหมายเลขบรรทัด
      })
    end

    -- =============================================================
    -- LSP keymaps (สร้างอัตโนมัติเมื่อ server ติดเข้ากับ buffer)
    -- =============================================================

    -- สร้าง autocmd ทุกครั้งที่ LSP attach กับบัฟเฟอร์
    vim.api.nvim_create_autocmd("LspAttach", {
      -- กลุ่ม autocommand ที่ใช้ร่วมกันได้ (ไม่ clear เพื่อไม่ชนกับตัวอื่น)
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),

      -- callback = ทำงานเมื่อ server เชื่อมกับ buffer
      callback = function(ev)
        -- opts: คีย์แมปแบบ buffer-local + silent (ไม่แสดง message ตอนกด)
        local opts = {
          buffer = ev.buf,
          silent = true,
        }

        -- References
        -- gR: หา references ทุกจุดที่อ้างถึงสัญลักษณ์ (ผ่าน Telescope)
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        -- Declaration
        -- gD: ไปที่ declaration (เช่น ตำแหน่งประกาศ interface/type)
        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        -- Definition
        -- gd: ไปที่ definition ของสัญลักษณ์ใต้เคอร์เซอร์ (ผ่าน Telescope)
        opts.desc = "Go to definition"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- Implementation
        -- gi: หา implementation ที่นำไปใช้งานจริง (ผ่าน Telescope)
        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- Type definition
        -- gt: ไปที่ type definition ของสัญลักษณ์ (ผ่าน Telescope)
        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- Code action
        -- <space>ca: ดู code actions ที่ใช้ได้ (เช่น auto-fix, quick fix)
        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Rename
        -- <space>rn: เปลี่ยนชื่อสัญลักษณ์ให้ครบทุกจุดที่อ้างถึง
        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Buffer diagnostics
        -- <space>D: แสดง diagnostics เฉพาะบัฟเฟอร์นี้ (ผ่าน Telescope)
        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        -- Line diagnostics
        -- <space>d: เปิดหน้าต่างลอยแสดง diagnostics ของบรรทัดปัจจุบัน
        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        -- Previous diagnostic
        -- [d: ไป diagnostics ก่อนหน้า
        opts.desc = "Go to previous diagnostics"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        -- Next diagnostic
        -- ]d: ไป diagnostics ถัดไป
        opts.desc = "Go to next diagnostics"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- Hover
        -- K: แสดงเอกสาร/คำอธิบายของสัญลักษณ์ใต้เคอร์เซอร์
        opts.desc = "Show documentation"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Format
        -- <space>f: ฟอร์แมตบัฟเฟอร์ผ่าน LSP (แบบ async)
        opts.desc = "Format buffer"
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
          vim.lsp.buf.format({
            async = true,
          })
        end, opts)

        -- Restart LSP
        -- <space>rs: รีสตาร์ท LSP server (เมื่อ server ค้าง/config เปลี่ยน)
        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
      end,
    })

    -- =============================================================
    -- Lua LSP (lua_ls) — ใช้ชี้ config ของ Neovim เอง
    -- =============================================================

    -- ตั้งค่า server lua_ls
    vim.lsp.config("lua_ls", {
      -- ส่ง capabilities (ให้ auto-complete ทำงานร่วมกับ cmp)
      capabilities = capabilities,

      -- settings = config เฉพาะของ lua_ls (ผ่าน init ของ server)
      settings = {
        Lua = {
          -- ตั้งค่าเรื่อง diagnostics ของ Lua
          diagnostics = {
            -- ประกาศว่า "vim" เป็น global ที่ถูกต้อง (ไม่ขึ้น error undefined)
            globals = {
              "vim",
            },
          },

          -- ตั้งค่าเรื่อง auto-complete / snippet
          completion = {
            -- ขยาย call snippet แบบแทนที่เนื้อหาเดิม (Replace)
            callSnippet = "Replace",
          },

          -- ตั้งค่า workspace (ขอบเขตโปรเจกต์)
          workspace = {
            -- ไม่ตรวจหา third-party library ของ Neovim ด้วยตัวมันเอง
            checkThirdParty = false,
          },

          -- ปิดการส่งข้อมูล telemetry ไปยัง Microsoft
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- =============================================================
    -- Svelte
    -- =============================================================

    -- ตั้งค่า svelte language server (svelteserver)
    vim.lsp.config("svelte", {
      -- ส่ง capabilities
      capabilities = capabilities,

      -- on_attach พิเศษ: เมื่อเซฟไฟล์ .js/.ts ภายในโปรเจกต์ svelte
      on_attach = function(client, bufnr)
        -- สร้าง autocmd เมื่อบันทึกไฟล์ใน buffer นี้
        vim.api.nvim_create_autocmd("BufWritePost", {
          buffer = bufnr,

          -- เฉพาะไฟล์ JS/TS (อัปเดต type ที่ .svelte ใช้)
          pattern = {
            "*.js",
            "*.ts",
          },

          -- callback = แจ้ง svelte server ว่าไฟล์เปลี่ยน
          callback = function(ctx)
            -- ส่ง notification $/onDidChangeTsOrJsFile ให้ server อัปเดต type
            client.notify("$/onDidChangeTsOrJsFile", {
              uri = ctx.match,
            })
          end,
        })
      end,
    })

    -- =============================================================
    -- GraphQL
    -- =============================================================

    -- ตั้งค่า graphql language server (graphql-lsp)
    vim.lsp.config("graphql", {
      -- ส่ง capabilities
      capabilities = capabilities,

      -- filetypes ที่จะให้กราฟQL server ทำงานด้วย
      filetypes = {
        "graphql", -- ไฟล์ .graphql/.gql ตรง ๆ
        "gql",
        "svelte", -- ภายในไฟล์ svelte
        "typescriptreact", -- ภายใน JSX/TSX
        "javascriptreact",
      },
    })

    -- =============================================================
    -- Emmet
    -- =============================================================

    -- ตั้งค่า emmet_ls (Emmet = ขยาย shorthand HTML/CSS ให้เอง)
    vim.lsp.config("emmet_ls", {
      -- ส่ง capabilities
      capabilities = capabilities,

      -- filetypes ที่เปิดใช้ Emmet
      filetypes = {
        "html",
        "typescriptreact", -- JSX/TSX
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
      },
    })

    -- =============================================================
    -- clangd (C / C++ / Objective-C)
    -- =============================================================

    -- ตั้งค่า clangd (จาก llvm) สำหรับภาษา C / C++
    vim.lsp.config("clangd", {
      -- ส่ง capabilities
      capabilities = capabilities,

      -- cmd = คำสั่งพร้อม flag ที่ใช้สตาร์ท clangd
      cmd = {
        "clangd",
        "--background-index", -- สร้างดัชนีโค้ดแบบเบื้องหลัง
        "--clang-tidy", -- เปิดใช้งาน clang-tidy lint
        "--completion-style=detailed", -- auto-complete แบบละเอียด
        "--header-insertion=iwyu", -- เสนอ include header ตาม include-what-you-use
        "--header-insertion-decorators", -- แสดงเครื่องหมายใน proposal ของ header
        "--function-arg-placeholders", -- แทรก placeholders ใน signature
        "--query-driver=/usr/bin/clang++", -- ชี้หา compile_commands จาก clang++ เส้น standard
        "--query-driver=/opt/homebrew/bin/clang++", -- ชี้หา clang++ ที่ติดตั้งผ่าน homebrew
        "--query-driver=/opt/homebrew/opt/llvm/bin/clang++", -- ชี้หา clang++ เวอร์ชัน llvm จาก homebrew
      },

      -- filetypes ที่จะเปิด clangd
      filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
      },
    })

    -- =============================================================
    -- Server กลุ่ม capabilities เท่านั้น (ตั้งค่าแค่ส่งความสามารถ)
    -- =============================================================

    -- TypeScript / JavaScript (typescript-language-server)
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })

    -- HTML language server (vscode-html-language-server)
    vim.lsp.config("html", {
      capabilities = capabilities,
      -- เปิดเฉพาะไฟล์ html เท่านั้น (ไม่ชนกับ emmet ที่ใช้ filetypes มากกว่า)
      filetypes = {
        "html",
      },
    })

    -- CSS language server (vscode-css-language-server)
    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })

    -- Tailwind CSS language server (tailwindcss-language-server)
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
    })

    -- Pyright (ภาษา Python)
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

    -- Prisma (prisma-language-server ใช้กับ schema ORM)
    vim.lsp.config("prismals", {
      capabilities = capabilities,
    })

    -- =============================================================
    -- Enable LSP servers
    -- =============================================================

    -- เปิดใช้ servers ทั้งหมดพร้อมกัน
    -- (ชื่อต้องตรงกับ ensure_installed ใน mason.lua ตัวไหนขาดต้องตรงกัน)
    vim.lsp.enable({
      "lua_ls", -- Lua
      "svelte", -- Svelte
      "graphql", -- GraphQL
      "emmet_ls", -- Emmet
      "ts_ls", -- TypeScript / JavaScript
      "html", -- HTML
      "cssls", -- CSS
      "tailwindcss", -- Tailwind CSS
      "pyright", -- Python
      "prismals", -- Prisma
      "clangd", -- C / C++
    })
  end,
}
