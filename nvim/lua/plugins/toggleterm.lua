return {
  "akinsho/toggleterm.nvim",
  version = "*",

  opts = {
    size = 15,

    open_mapping = [[<C-\>]],

    hide_numbers = true,

    shade_terminals = true,

    start_in_insert = true,

    insert_mappings = true,

    terminal_mappings = true,

    persist_size = true,

    direction = "horizontal",

    close_on_exit = true,

    shell = vim.o.shell,

    float_opts = {
      border = "curved",
    },

    -- -- กด Esc แล้วปิด Terminal
    -- on_open = function(term)
    --   vim.keymap.set("t", "<Esc>", function()
    --     term:toggle()
    --   end, {
    --     buffer = term.bufnr,
    --     silent = true,
    --     desc = "Close terminal",
    --   })
    --end,
  },

  keys = {
    {
      "<leader>tt",
      "<cmd>ToggleTerm<CR>",
      desc = "Toggle terminal",
    },

    {
      "<leader>tf",
      "<cmd>ToggleTerm direction=float<CR>",
      desc = "Toggle floating terminal",
    },

    {
      "<leader>tv",
      "<cmd>ToggleTerm direction=vertical<CR>",
      desc = "Toggle vertical terminal",
    },

    {
      "<leader>th",
      "<cmd>ToggleTerm direction=horizontal<CR>",
      desc = "Toggle horizontal terminal",
    },
  },
}
