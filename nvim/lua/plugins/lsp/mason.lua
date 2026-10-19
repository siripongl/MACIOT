-- ==================================================================
-- mason.nvim: ตัวติดตั้ง LSP servers / linters / formatters / tools
-- ----------------------------------------------------------------
-- ไฟล์นี้เป็นสเปกของ lazy.nvim หนึ่งตัว (ตัวอย่าง "หนึ่งไฟล์ = หนึ่งหัวข้อ")
-- ทุกอย่างที่ Mason ติดตั้งจะลงใน ~/.local/share/nvim/mason (stdpath "data")
-- ห้ามกำหนด path เองเด็ดขาด — อ้างอิงแค่ "ชื่อ server" เท่านั้น
-- ==================================================================

return {
  -- ชื่อ plugin หลักของ tab:Mason ที่ lazy.nvim จะติดตั้ง
  "mason-org/mason.nvim",

  -- dependencies = plugin เสริมที่ต้องโหลดพร้อม (หรือก่อน) กัน
  dependencies = {
    -- เชื่อม Mason เข้ากับ nvim-lspconfig: รู้ว่าต้องติดตั้งตัวไหนตามชื่อ server
    "mason-org/mason-lspconfig.nvim",
    -- ตัวช่วยติดตั้ง tools ที่ไม่ใช่ LSP (formatter/linter) ตาม ensure_installed
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  -- config = ฟังก์ชันที่ lazy.nvim เรียกเมื่อโหลด plugin (ตั้งค่า Mason ทั้งชุด)
  config = function()
    -- require โมดูล mason หลัก (ชื่อเดียวกับ repo: mason)
    local mason = require("mason")
    -- require โมดูล mason-lspconfig (จัดการรายชื่อ LSP servers)
    local mason_lspconfig = require("mason-lspconfig")
    -- require โมดูล mason-tool-installer (จัดการ formatter/linter)
    local mason_tool_installer = require("mason-tool-installer")

    -- ตั้งค่า mason: ปรับเปลี่ยน UI ของหน้าต่าง :Mason
    mason.setup({
      -- UI ของหน้าต่าง :Mason
      ui = {
        -- ขอบหน้าต่างเป็นแบบมน (rounded)
        border = "rounded",
        -- ไอคอนบอกสถานะของแต่ละ package ในหน้าต่าง :Mason
        icons = {
          -- ติดตั้งเรียบร้อยแล้ว
          package_installed = "",
          -- กำลังติดตั้ง / ค้างอยู่ระหว่างดาวน์โหลด
          package_pending = "",
          -- ยังไม่ได้ติดตั้ง
          package_uninstalled = "",
        },
      },
    })

    -- ตั้งค่า mason-lspconfig: ติดตั้ง LSP servers ให้อัตโนมัติตอน first run
    mason_lspconfig.setup({
      -- รายชื่อนี้ต้องตรงกับ vim.lsp.enable({...}) ในไฟล์ lspconfig.lua เสมอ
      ensure_installed = {
        "ts_ls", -- TypeScript / JavaScript (typescript-language-server)
        "html", -- HTML (vscode-html-language-server)
        "cssls", -- CSS (vscode-css-language-server)
        "tailwindcss", -- Tailwind CSS (tailwindcss-language-server)
        "svelte", -- Svelte (svelteserver)
        "lua_ls", -- Lua (lua-language-server — ใช้กับ config นี้เอง)
        "graphql", -- GraphQL (graphql-lsp)
        "emmet_ls", -- Emmet: ขยาย shorthand HTML/CSS ให้เอง
        "prismals", -- Prisma (prisma-language-server — ใช้ใน schema ORM)
        "pyright", -- Python (pyright / pyright-langserver)
        "clangd", -- C / C++ (clangd — จาก llvm)
      },

      -- ให้ lspconfig.lua เป็นผู้ควบคุมการ enable LSP
      automatic_enable = false,
    })

    -- ตั้งค่า mason-tool-installer: ติดตั้ง formatter/linter ที่ไม่ใช่ LSP
    mason_tool_installer.setup({
      -- รายชื่อเครื่องมือที่จะติดตั้งให้อัตโนมัติ (installed ไว้ใช้กับ conform/lint)
      ensure_installed = {
        "prettier", -- formatter ของ web: js/ts/css/html/json/yaml/md/...
        "stylua", -- formatter ของ Lua — ใช้ฟอร์แมต config นี้เองตอนเซฟ
        "isort", -- จัดเรียงลำดับ import ของ Python
        "black", -- formatter ของ Python (ตาม PEP 8)
        "pylint", -- linter ของ Python
        "eslint_d", -- linter ของ JS/TS เวอร์ชันที่จำลองแค่ตัวเดียว (เร็ว)
      },
    })
  end,
}
