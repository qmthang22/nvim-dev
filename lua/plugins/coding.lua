return {
  -- ✅ Incremental rename (đổi tên biến trực tiếp khi đang gõ)
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename", -- Chỉ load plugin khi gọi lệnh :IncRename
    config = true, -- Dùng cấu hình mặc định
  },

  -- ✅ Di chuyển nhanh bằng dấu ngoặc vuông như [q, ]q, [y, ]y...
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost", -- Chỉ tải plugin sau khi mở file
    config = function()
      local bracketed = require("mini.bracketed")
      bracketed.setup({
        file = { suffix = "" }, -- ]f / [f: chuyển file
        window = { suffix = "" }, -- ]w / [w: chuyển cửa sổ
        quickfix = { suffix = "" }, -- ]q / [q: quickfix
        yank = { suffix = "" }, -- ]y / [y: vùng yank
        treesitter = { suffix = "n" }, -- ]n / [n: node Treesitter
      })
    end,
  },

  -- ✅ Tăng / giảm giá trị thông minh (số, ngày, bool, version...)
  {
    "monaqa/dial.nvim",
		-- stylua: ignore
		keys = {
			-- Ctrl-a: tăng giá trị (số, ngày, true → false,...)
			{ "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
			-- Ctrl-x: giảm giá trị
			{ "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
		},
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal, -- Số thập phân
          augend.integer.alias.hex, -- Số hex
          augend.date.alias["%Y/%m/%d"], -- Ngày tháng kiểu 2025/05/22
          augend.constant.alias.bool, -- true/false
          augend.semver.alias.semver, -- version kiểu 1.0.0
          augend.constant.new({
            elements = { "let", "const" }, -- let ↔ const
          }),
        },
      })
    end,
  },

  -- ✅ GitHub Copilot (AI hỗ trợ code thông minh)
  --   {
  --     "zbirenbaum/copilot.lua",
  --     opts = {
  --       suggestion = {
  --         auto_trigger = true, -- Tự động gợi ý khi đang gõ
  --         keymap = {
  --           accept = "<C-l>", -- Chấp nhận gợi ý đầy đủ
  --           accept_word = "<M-l>", -- Chấp nhận một từ
  --           accept_line = "<M-S-l>", -- Chấp nhận cả dòng
  --           next = "<M-]>", -- Gợi ý tiếp theo
  --           prev = "<M-[>", -- Gợi ý trước đó
  --           dismiss = "<C-]>", -- Ẩn gợi ý
  --         },
  --       },
  --       filetypes = {
  --         markdown = true, -- Bật Copilot cho Markdown
  --         help = true, -- Bật Copilot cho file help
  --         -- Các filetype khác sẽ dùng mặc định của Copilot
  --       },
  --     },
  --   },
}
