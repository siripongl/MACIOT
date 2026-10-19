-- =====================================================
-- gitsigns.nvim: แสดงสัญญาณ git (เพิ่ม/ลบ/เปลี่ยน) ริมบรรทัด + คีย์แมปจัดการ hunk
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ gitsigns
return {
  "lewis6991/gitsigns.nvim",

  -- โหลดเมื่อเปิดอ่านไฟล์
  event = { "BufReadPre", "BufNewFile" },

  -- opts: lazy.nvim เรียก setup() อัตโนมัติด้วยตารางนี้
  opts = {
    -- on_attach ทำงานเมื่อ gitsigns ผูกกับบัฟเฟอร์ (สร้างคีย์แมประดับ buffer)
    on_attach = function(bufnr)
      -- package.loaded.gitsigns ดึงตัว gitsigns ที่โหลดจริง (API ปัจจุบัน)
      local gs = package.loaded.gitsigns

      -- ฟังก์ชันช่วยแมปคีย์ให้สั้นลง โดยจำกัดเฉพาะ buffer ปัจจุบัน (buffer = bufnr)
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, {
          buffer = bufnr,
          desc = desc,
        })
      end

      -- Navigation
      -- ]h: ข้ามไป hunk ถัดไป
      map("n", "]h", gs.next_hunk, "Next Hunk")
      -- [h: ย้อนกลับ hunk ก่อนหน้า
      map("n", "[h", gs.prev_hunk, "Prev Hunk")

      -- Actions
      -- <space>hs: จัดการ (stage) hunk ที่เคอร์เซอร์
      map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
      -- <space>hr: ยกเลิกการแก้ไข (reset) hunk ที่เคอร์เซอร์
      map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")

      -- <space>hs: (โหมด visual) stage ช่วงบรรทัดที่เลือกไว้
      map("v", "<leader>hs", function()
        gs.stage_hunk({
          vim.fn.line("."),
          vim.fn.line("v"),
        })
      end, "Stage Hunk")

      -- <space>hr: (โหมด visual) reset ช่วงบรรทัดที่เลือกไว้
      map("v", "<leader>hr", function()
        gs.reset_hunk({
          vim.fn.line("."),
          vim.fn.line("v"),
        })
      end, "Reset Hunk")

      -- <space>hS: stage ทั้งไฟล์ (buffer)
      map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
      -- <space>hR: reset ทั้งไฟล์ (buffer)
      map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")

      -- <space>hu: เลิก stage hunk (กลับเป็น unstaged)
      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
      -- <space>hp: ดู preview ของความเปลี่ยนแปลงใน hunk
      map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")

      -- <space>hb: แสดง blame ของบรรทัดปัจจุบัน (ใครแก้ เมื่อไหร่)
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")

      -- <space>hB: เปิด/ปิด blame แบบจอด้านข้าง (virtual text)
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle Line Blame")

      -- <space>hd: เปิด diff ของไฟล์นี้ vs HEAD (เวอร์ชัน committed ล่าสุด)
      map("n", "<leader>hd", gs.diffthis, "Diff This")

      -- <space>hD: เปิด diff เทียบกับ commit หนึ่งก่อนหน้า (~)
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff This ~")

      -- Text object
      -- ih: เลือก hunk ทั้งหมดด้วย text object (ใช้กับ operator ได้ เช่น cih, dih)
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns Select Hunk")
    end,
  },
}
