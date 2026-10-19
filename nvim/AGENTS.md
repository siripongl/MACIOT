<!-- ==================================================== -->
<!-- AGENTS.md — คู่มือสำหรับ OpenCode session ถัดไป           -->
<!-- อ่านก่อน: โครงสร้าง + คำสั่งตรวจสอบ + กับดักของ repo    -->
<!-- ==================================================== -->

# AGENTS.md

<!--
  บรรทัดแรกสุด: หนึ่งประโยคว่า repo นี้คืออะไร + เทคโนโลยีหลัก
  จำเป็นต้องบอกว่า "ไม่ใช่ git repo" เพราะ agent มักสุ่มไปรัน git โดยไม่รู้
-->
Personal Neovim ≥ 0.12 config using lazy.nvim. Lua only — no package manager, no build step. **Not a git repo.**

## Layout

<!--
  โครงสร้างนี้ไม่ตรงกับโปรเจกต์ Neovim ทั่วไป (ไม่มี init.lua ใหญ่ ๆ ไฟล์เดียว)
  ต้องดูให้ออกว่า "load ลำดับไหน" ถึงจะรู้ว่าจะแก้อะไรที่ไหน
-->
- `init.lua` → loads `lua/core/` (options, keymaps) then `lua/core/lazy.lua`

<!--
  คำอธิบายบรรทัดบน: init.lua เป็นทางเข้าเท่านั้น เป็นแบบบาง (thin)
  ไฟล์จริงทุกตัวอยู่ใน lua/core/ และ lua/plugins/ — อย่าไปแก้โค้ดใน init.lua
-->
- `lua/core/lazy.lua` bootstraps lazy.nvim into `stdpath("data")/lazy/lazy.nvim` on first run, then imports every spec under `plugins` and `plugins.lsp`

<!--
  บรรทัดบน: lazy.nvim ติดตั้งตัวเองอัตโนมัติในครั้งแรกที่รัน (clone จาก GitHub)
  แล้ว import เข้าไปทุกไฟล์ใต้โฟลเดอร์ plugins -> การเพิ่ม plugin ไม่ต้องแก้ไฟล์นี้อีก
-->
- `lua/plugins/*.lua` — one lazy.nvim spec file per plugin (each returns a spec table). `plugins/init.lua` is itself a spec list of shared deps (plenary, vim-tmux-navigator)

<!--
  บรรทัดบน: ระเบียบ "หนึ่งไฟล์ต่อหนึ่ง plugin" — ทุกไฟล์ต้อง return spec table
  อย่าสับสน plugins/init.lua กับ "main runner"; มันคือ spec ธรรมดาสำหรับตัวช่วยร่วม
-->
- `lua/plugins/lsp/` — `mason.lua` (tool installer) and `lspconfig.lua` (all LSP server config)

<!--
  บรรทัดบน: ส่วน LSP แยกโฟลเดอร์ลงไปอีกชั้น ลึกกว่า plugins ทั่วไป
  ลำดับสำคัญ: ติดตั้ง Tool ผ่าน mason ก่อน แล้วตั้งค่า/เปิดใช้ผ่าน lspconfig
-->

## Adding/editing plugins

<!--
  วิธีเพิ่ม plugin — จุดที่ agent มักผิดบ่อยที่สุดคือไปแก้ core/lazy.lua เพื่อ register
  ความจริง lazy import อัตโนมัติจากชื่อไฟล์ในโฟลเดอร์ plugins โดยไม่ต้องลงทะเบียนเอง
-->
- A new plugin = new file in `lua/plugins/` returning a spec, or add to an existing file. The `{ import = "plugins" }` / `{ import = "plugins.lsp" }` in `core/lazy.lua` picks up any file automatically — do not edit lazy config per-plugin.

<!--
  เคล็ดลับเพิ่ม: ตั้ง key/event/cmd ใน spec เพื่อให้ lazy-load (โหลดเฉพาะเมื่อใช้)
  ซึ่งเป็นรูปแบบมาตรฐานของทุกไฟล์ในโฟลเดอร์นี้แล้ว — ทำตามตัวอย่างไฟล์ข้างเคียง
-->
- Refresh with `:Lazy`, sync pins via `:Lazy update` (updates `lazy-lock.json`).

<!--
  lazy-lock.json = ไฟล์ล็อก commit ของ plugin ทุกตัว (ถูกสร้าง/อัปเดตโดย :Lazy)
  ใช้สำหรับย้อนกลับเวอร์ชันเมื่อมี plugin พัง — แต่มันไม่มี git เก็บตาม ต้องระวัง
-->

## LSP conventions (non-obvious)

<!--
  ส่วนนี้ "โค้ดบอกเองไม่ได้" — ถ้าไม่เขียนไว้ agent จะเผลอไปใช้ API เก่า
  เพราะ tutorial ส่วนใหญ่ในอินเทอร์เน็ตยังเป็นรูปแบบเก่า
-->
- Uses the modern `vim.lsp.config()` / `vim.lsp.enable()` API (Neovim ≥ 0.11; current version 0.12.5). Do not migrate to legacy `setup{}`/`on_attach` style.

<!--
  บรรทัดบน: โค้ดนี้เขียนเป็น API สมัยใหม่ของ Neovim (≥0.11)
  อย่า "ช่วย" แปลงกลับเป็น syntax เก่า (vim.lsp.<name>_setup / on_attach) เพราะจะพัง
-->
- `lspconfig.lua` servers configured via `vim.lsp.config("<name>")` and enabled in one `vim.lsp.enable({...})` call. Keep that list in sync with the `mason_lspconfig` `ensure_installed` list in `mason.lua`.

<!--
  LSP มี "แหล่งข้อมูลเดียว" คือโฟลเดอร์ lsp/ เท่านั้น
  เคยมี lua/plugins/lsp.lua ตัวเก่าซ้ำกับไฟล์ในโฟลเดอร์นี้ — ลบแล้ว
  lazy.nvim import plugins.lsp จะโหลดทั้ง lsp.lua AND lsp/*.lua
  ถ้าใครสร้าง lsp.lua กลับมาอีก config จะวิ่งซ้ำกันสองชุด อย่าทำ
-->
- LSP config lives ONLY in `lua/plugins/lsp/{mason.lua,lspconfig.lua}`. Do NOT add a standalone `lua/plugins/lsp.lua`: lazy's `{ import = "plugins.lsp" }` loads it in addition to the `lsp/` folder files, so both configs run merged (a duplicate was deleted during a cleanup). `clangd` and `neodev.nvim` are now wired into the `lsp/` files.

<!--
  บรรทัดบน: รายชื่อ server มีอยู่ 2 จุดที่ต้องตรงกันเสมอ:
  1) vim.lsp.enable({...}) ใน lspconfig.lua  2) ensure_installed ใน mason.lua
  ถ้าเพิ่ม server ที่ไหนที่หนึ่งโดยลืมอีกที่ ฝั่งหนึ่งจะไม่ work (server ไม่ถูกเปิด/ไม่ถูกติดตั้ง)
-->

## Formatting / verification

<!--
  คำสั่งตรวจสอบ — agent อ่านแล้วต้องรันได้ทันที ไม่ต้องเดา
  ระดับการตรวจ: stylua (รูปแบบโค้ด) -> headless run (โหลด config จริง)
-->
- Lua formatting is stylua, 2-space indent (`.stylua.toml`; stylua 2.5.2). Conform.nvim formats `lua` files with stylua **on save**, so edits will be reformatted automatically — match stylua style to avoid churn.

<!--
  บรรทัดบน: ตัว config นี้ "ฟอร์แมตตัวเอง" ด้วย conform ตอนกดเซฟ (lua -> stylua)
  ดังนั้นถ้าแก้ไฟล์ lua แล้วเซฟ ไฟล์จะถูกปรับรูปแบบเอง — ควรเขียนให้สอดคล้อง stylua ตั้งแต่แรก
-->
- Check formatting: `stylua --check lua`

<!-- ตรวจว่าทุกไฟล์ผ่านรูปแบบ stylua หรือยัง (คืนค่า 0 = ผ่าน) -->
- Check config loads: `nvim --headless "+qa"` — startup/Lua errors surface on stderr.

<!--
  เปิด Neovim แบบไม่มีหน้าต่าง (headless) แล้วปิดทันที
  ถ้า config พัง จะมี error ขึ้นทาง stderr — วิธีตรวจสอบเร็วที่สุดหลังแก้ไฟล์
-->
- `:checkhealth` and `:messages` for diagnostics.

<!--
  :checkhealth = รายงานความพร้อมระบบของ plugins ที่ติดตั้ง
  :messages    = ดูข้อความ error/notice ล่าสุดของ Neovim (หลังเปิด headless ตรวจก็ดูที่นี่ได้)
-->

## Gotchas

<!--
  กับดักทั้งหมดนี้ "ตรวจจากโค้ดได้ก็จริง แต่ใช้เวลา" — เขียนไว้เพื่อกันพลาด
-->
- Leader is `<space>`; most keymaps live inline in the relevant plugin file plus `lua/core/keymaps.lua`.

<!--
  leader = space (ตั้งใน core/keymaps.lua) คีย์แมปส่วนใหญ่อยู่ในไฟล์ plugin นั้น ๆ
  อยากแกาคีย์ไหน -> หาจากไฟล์ plugin ที่เกี่ยวกับสิ่งนั้นก่อน (ซึ่ง-key ก็ช่วยบอกได้)
-->
- Some fix-annotated comments are written in Thai; ignore as noise.

<!--
  เจ้าของ config เขียนโน้ตแก้ไขเป็นภาษาไทยปนในคอมเมนต์ (เช่น "FIXED: ...")
  อ่านได้ แต่ไม่ใช่ข้อกำหนดของโค้ด — เก็บไว้ได้ ห้ามลบทิ้งโดยไม่จำเป็น
-->
- LSP/tool binaries are installed by Mason into `stdpath("data")/mason` — don't commit or override installed paths.

<!--
  paths ของ server/tool ถูก Mason จัดการเอง (ติดตั้ง/อัปเดตผ่าน :Mason)
  มันระบุไว้ใน config ได้แค่ "ชื่อ" — ห้ามแก้ path เองเด็ดขาด ไม่งั้น server ใช้ไม่ได้
-->
- `lazygit` CLI is required separately via `brew install lazygit` — Mason does NOT install it.

<!--
  lazygit.nvim เป็นเพียง wrapper; ตัว binary `lazygit` ต้องติดตั้งภายนอก (brew)
  ถ้ายังไม่ได้ติดตั้ง การกด <leader>lg จะ error — ตรวจสอบ /homebrew ก่อน หรือรัน brew install lazygit
-->
- `NvimTree_1` (empty file in repo root) is a stray nvim-tree artifact; ignore.

<!--
  init.lua มี print ค้างไว้ว่า "Update todo-comments.lua" มันออกทุกครั้งที่เปิด Neovim
  อย่าเข้าใจผิดว่าคือ error — `nvim --headless "+qa"` มี output แค่บรรทัดนี้ = config ปกติ
-->
- `init.lua` has a leftover debug `print("Update todo-comments.lua")` that prints on every startup (seen in `nvim --headless "+qa"` output). It's harmless noise, not an error — leave it or remove it, but don't treat it as a failure signal.

<!--
  ไฟล์ว่าง NvimTree_1 เกิดจาก nvim-tree ทิ้ง artifact ไว้ตอนเปิด/ปิด explorer
  เป็นไฟล์ขยะจริง ไม่ใช่ส่วนของ config — ลบได้ ไม่ต้องเก็บ ไม่ต้องแก้
-->