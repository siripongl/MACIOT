-- =====================================================
-- conform.nvim: ฟอร์แมตโค้ดเมื่อบันทึกไฟล์ (format on save) + คีย์แมปฟอร์แมตด้วยมือ
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ conform
return {
  "stevearc/conform.nvim",
  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },
  -- config: ตั้งค่าพลักอิน
  config = function()
    -- ดึงตัว conform มาใช้
    local conform = require("conform")

    conform.setup({
      -- บอกว่าภาษาไหนใช้ฟอร์แมตเตอร์ตัวไหน (คีย์ = filetype)
      formatters_by_ft = {
        -- FIXED: เดิมพิมพ์ผิดเป็น "javaascript" และลืมปิด `end` ของ config function
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        -- ฟอร์แมต Lua config นี้ด้วย stylua (ไฟล์นี้เองจะถูกปรับอัตโนมัติเวลาเซฟ)
        lua = { "stylua" },
        -- python: isort จัดเรียง import ก่อน แล้ว black ฟอร์แมตโค้ด
        python = { "isort", "black" },
      },
      -- ฟอร์แมตอัตโนมัติทุกครั้งที่บันทึกไฟล์
      format_on_save = {
        -- ถ้าไม่มี formatter ตรงกัน ให้ลองใช้ LSP format แทน
        lsp_fallback = true,
        -- ฟอร์แมตแบบ synchronous (ไม่ค้างคิว)
        async = false,
        -- ไม่รอเกิน 1 วินาที ไม่เช่นนั้นข้ามไป
        timeout_ms = 1000,
      },
    })

    -- <space>mp: ฟอร์แมตไฟล์ทั้งหมด (normal) หรือช่วงที่เลือก (visual) ตามที่ต้องการ
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
