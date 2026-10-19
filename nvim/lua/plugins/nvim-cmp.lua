-- =====================================================
-- nvim-cmp: ระบบ autocompletion (code suggestion) กลางของ Neovim
-- รวบรวมแหล่งข้อมูลจาก LSP, snippets, ข้อความใน buffer และ path
-- -----------------------------------------------------
-- คืนค่าสเปกของ lazy.nvim สำหรับ nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  -- โหลดเมื่อเริ่มพิมพ์ (เข้าโหมด insert)
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      -- LuaSnip: ตัวจัดการ snippets (snippet engine)
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      -- โฟกัสที่เวอร์ชัน v2.* (stable) ของ LuaSnip
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest)
      -- install jsregexp (optional!).
      -- build: ติดตั้ง jsregexp เพิ่ม (optional) สำหรับความเร็ว regex ใน snippets
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", --for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  -- config: ตั้งค่าพลักอิน
  config = function()
    -- ดึงตัว cmp มาใช้
    local cmp = require("cmp")
    -- ดึง LuaSnip มาใช้ (จัดการ snippet)
    local luasnip = require("luasnip")
    -- ดึง lspkind มาใช้ (แสดงไอคอนรูปภาพข้างคำแนะนำแบบ VS Code)
    local lspkind = require("lspkind")

    -- load vscode style snippets for installed plugins (e.g. friendly-snippets)
    -- โหลด snippets แบบ vscode (จาก friendly-snippets) แบบ lazy (โหลดช้าเมื่อจำเป็น)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      -- define behavior of the completion window (choosing + pressing enter)
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      -- วิธีที่ cmp ขยาย snippet เมื่อเลือก (ใช้ LuaSnip ขยาย)
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- mapping: ปุ่มลัดภายในหน้าต่าง completion
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      --sources for autocompletion
      -- แหล่งที่มาของคำแนะนำ: LSP, snippets, buffer, path (ตามลำดับความสำคัญ)
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, --snippets
        { name = "buffer" }, --text within current buffer
        { name = "path" }, --file system paths
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      -- รูปแบบการแสดงผล: ใช้ lspkind เพิ่มไอคอนหน้าคำแนะนำ (จำกัดความกว้าง 50 ตัว)
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
