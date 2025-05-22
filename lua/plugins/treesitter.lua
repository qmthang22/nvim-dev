return {
  -- Plugin để hiển thị và thử nghiệm các truy vấn Treesitter
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Danh sách các parser cần cài đặt để hỗ trợ ngôn ngữ tương ứng
      ensure_installed = {
        "astro",
        "cmake",
        "cpp",
        "css",
        "fish",
        "gitignore",
        "go",
        "graphql",
        "http",
        "java",
        "php",
        "rust",
        "scss",
        "sql",
        "svelte",
      },

      -- Linter cho truy vấn Treesitter
      query_linter = {
        enable = true, -- Bật linter
        use_virtual_text = true, -- Hiển thị lỗi bằng virtual text trong file
        lint_events = { "BufWrite", "CursorHold" }, -- Chạy linter khi ghi file hoặc giữ con trỏ
      },

      -- Cấu hình playground để thử nghiệm truy vấn và highlight cây cú pháp
      playground = {
        enable = true, -- Bật playground
        disable = {},
        updatetime = 25, -- Thời gian debounce để cập nhật highlight
        persist_queries = true, -- Lưu truy vấn qua các phiên làm việc
        keybindings = {
          toggle_query_editor = "o", -- Mở/tắt trình chỉnh sửa truy vấn
          toggle_hl_groups = "i", -- Bật/tắt highlight nhóm
          toggle_injected_languages = "t", -- Bật/tắt highlight ngôn ngữ được nhúng
          toggle_anonymous_nodes = "a", -- Bật/tắt node ẩn danh
          toggle_language_display = "I", -- Bật/tắt hiển thị ngôn ngữ
          focus_language = "f", -- Tập trung vào ngôn ngữ cụ thể
          unfocus_language = "F", -- Bỏ tập trung khỏi ngôn ngữ
          update = "R", -- Cập nhật cây cú pháp
          goto_node = "<cr>", -- Di chuyển đến node trong source
          show_help = "?", -- Hiển thị trợ giúp
        },
      },
    },

    -- Hàm cấu hình được gọi khi plugin được nạp
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Thêm hỗ trợ cho file có phần mở rộng .mdx (MDX là Markdown mở rộng)
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      -- Đăng ký ngôn ngữ markdown cho file mdx để dùng chung cú pháp Treesitter
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
