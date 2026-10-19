-- =====================================================
-- todo-comments.nvim
-- Highlight / Search / Jump TODO, FIX, HACK, WARN, ...
-- =====================================================

return {
  "folke/todo-comments.nvim",

  -- Load when opening a file
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    -- ===================================================
    -- Signs
    -- ===================================================
    signs = true,
    sign_priority = 8,

    -- ===================================================
    -- Keywords
    -- ===================================================
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },

      TODO = {
        icon = " ",
        color = "info",
      },

      HACK = {
        icon = " ",
        color = "warning",
      },

      WARN = {
        icon = " ",
        color = "warning",
        alt = { "WARNING", "XXX" },
      },

      PERF = {
        icon = " ",
        color = "warning",
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },

      NOTE = {
        icon = " ",
        color = "hint",
        alt = { "INFO" },
      },

      TEST = {
        icon = "⏲ ",
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },

    -- Merge custom keywords with the default keywords
    merge_keywords = true,

    -- ===================================================
    -- GUI Style
    -- ===================================================
    gui_style = {
      fg = "NONE",
      bg = "BOLD",
    },

    -- ===================================================
    -- Highlight
    -- ===================================================
    highlight = {
      multiline = true,
      multiline_pattern = "^.",
      multiline_context = 10,

      before = "",
      keyword = "wide",
      after = "fg",

      pattern = [[.*<(KEYWORDS)\s*:]],

      comments_only = true,

      max_line_len = 400,

      exclude = {},
    },

    -- ===================================================
    -- Colors
    -- ===================================================
    colors = {
      error = {
        "DiagnosticError",
        "ErrorMsg",
        "#DC2626",
      },

      warning = {
        "DiagnosticWarn",
        "WarningMsg",
        "#FBBF24",
      },

      info = {
        "DiagnosticInfo",
        "#2563EB",
      },

      hint = {
        "DiagnosticHint",
        "#10B981",
      },

      default = {
        "Identifier",
        "#7C3AED",
      },

      test = {
        "Identifier",
        "#FF00FF",
      },
    },

    -- ===================================================
    -- Search
    -- ===================================================
    search = {
      command = "rg",

      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },

      pattern = [[\b(KEYWORDS):]],
    },
  },

  -- =====================================================
  -- Keymaps
  -- =====================================================
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next TODO comment",
    },

    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous TODO comment",
    },

    {
      "<leader>ft",
      "<cmd>TodoTelescope<CR>",
      desc = "Find TODO comments",
    },

    {
      "<leader>fq",
      "<cmd>TodoQuickFix<CR>",
      desc = "TODO Quickfix",
    },

    {
      "<leader>fl",
      "<cmd>TodoLocList<CR>",
      desc = "TODO Location List",
    },

    {
      "<leader>xt",
      "<cmd>Trouble todo toggle<CR>",
      desc = "TODOs in Trouble",
    },
  },
}
