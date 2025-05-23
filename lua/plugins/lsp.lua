return {
  -- ✅ MASON: Trình quản lý cài đặt LSP, DAP, formatter, linter...
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Mở rộng danh sách tool sẽ tự động cài khi mở Neovim
      vim.list_extend(opts.ensure_installed, {
        "stylua", -- định dạng code Lua
        "selene", -- linter Lua
        "luacheck", -- linter Lua
        "shellcheck", -- kiểm tra shell script
        "shfmt", -- định dạng shell script
        "tailwindcss-language-server", -- hỗ trợ LSP cho TailwindCSS
        "typescript-language-server", -- LSP cho TypeScript
        "css-lsp", -- LSP cho CSS
      })
    end,
  },

  -- ✅ LSP CONFIG: Cấu hình các ngôn ngữ được Mason cài ở trên
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- ❌ Tắt inlay hint mặc định của Neovim (nếu có plugin khác xử lý)
      inlay_hints = { enabled = false },

      -- 🧠 Cấu hình server LSP cụ thể cho từng ngôn ngữ
      ---@type lspconfig.options
      servers = {
        -- 👉 CSS
        cssls = {},

        -- 👉 TailwindCSS: thiết lập root project là thư mục chứa .git
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },

        -- 👉 TypeScript/JavaScript
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false, -- Chỉ kích hoạt khi có project
          settings = {
            -- Inlay Hint cho TypeScript
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            -- Inlay Hint cho JavaScript
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        -- 👉 HTML
        html = {
          filetypes = {
            "html",
            "htmldjango",
          },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- 👉 YAML
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false, -- Không ép sắp xếp key trong YAML
            },
          },
        },

        -- 👉 Lua
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false, -- Không cảnh báo workspace bên thứ 3
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both", -- Gợi ý cả hàm có snippet
              },
              misc = {
                parameters = {
                  -- "--log-level=trace", -- (Bỏ comment để debug)
                },
              },
              hint = {
                enable = true, -- Bật gợi ý inline
                setType = false, -- Không hiện gợi ý kiểu cho `set`
                paramType = true, -- Gợi ý kiểu tham số
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" }, -- Biến bắt đầu bằng "_" là private
              },
              type = {
                castNumberToInteger = true, -- Ép kiểu số thành integer nếu cần
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" }, -- Biến bắt đầu bằng "_" không báo unused
              },
              format = {
                enable = false, -- Không bật autoformat
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },

      -- Có thể cấu hình thêm các hành vi khởi tạo server ở đây
      setup = {},
    },
  },

  -- ✅ Gán phím cho LSP actions (như `gd`) bằng Telescope
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd", -- Goto Definition
          function()
            -- Mở định nghĩa bằng Telescope, KHÔNG tái sử dụng cửa sổ hiện tại
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition",
          has = "definition", -- Chỉ map nếu server có hỗ trợ "definition"
        },
      })
    end,
  },
}
