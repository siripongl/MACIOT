-- =====================================================
-- nvim-lint: ลินต์โค้ดด้วยเครื่องมือภายนอก (eslint_d, pylint) แบบ async
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ nvim-lint
return {
  "mfussenegger/nvim-lint",
  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },
  -- config: ตั้งค่าพลักอิน
  config = function()
    -- ดึงตัว lint มาใช้
    local lint = require("lint")

    -- บอกว่าแต่ละภาษา (filetype) ใช้ลินเทอร์ตัวไหน
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      -- FIXED: เดิมเขียนเป็น "pylit" (ไม่มีอยู่จริง) -> แก้เป็น "pylint" (Mason ติดตั้งให้แล้ว)
      python = { "pylint" },
    }

    -- สร้าง autocommand group ชื่อ "lint" (clear = true ลบของเก่าทิ้งก่อนสร้างใหม่)
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- รันลินต์อัตโนมัติเมื่อ: เข้าบัฟเฟอร์ / เซฟไฟล์ / ออกจากโหมด insert
    vim.api.nvim_create_autocmd({ "BufEnter", "BufwritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- <space>l: ลินต์ไฟล์ปัจจุบันด้วยมือ
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
