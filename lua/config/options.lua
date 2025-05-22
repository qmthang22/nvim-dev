-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Thiết lập leader key
vim.g.mapleader = " "

-- Mã hóa file
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Hiện số dòng
vim.opt.number = true

-- Hiện tiêu đề cửa sổ terminal
vim.opt.title = true

-- Tự động thụt dòng
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Highlight kết quả tìm kiếm
vim.opt.hlsearch = true

-- Không tạo file backup
vim.opt.backup = false

-- Hiện lệnh đang gõ ở dưới thanh trạng thái
vim.opt.showcmd = true

-- Chiều cao của thanh lệnh
vim.opt.cmdheight = 1

-- Luôn hiển thị thanh trạng thái
vim.opt.laststatus = 3

-- Dùng space thay vì tab
vim.opt.expandtab = true

-- Cuộn tối thiểu 10 dòng khi di chuyển
vim.opt.scrolloff = 10

-- Dùng shell fish trong Neovim terminal
vim.opt.shell = "fish"

-- Không backup các file trong thư mục tạm
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }

-- Hiển thị thay đổi tìm kiếm trực tiếp
vim.opt.inccommand = "split"

-- Tìm kiếm không phân biệt hoa thường
vim.opt.ignorecase = true

-- Tab thông minh
vim.opt.smarttab = true

-- Giữ thụt dòng khi xuống hàng
vim.opt.breakindent = true

-- Đặt độ rộng thụt dòng và tab = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Không tự xuống dòng khi dòng dài
vim.opt.wrap = false

-- Cho phép xóa lui ở đầu dòng, giữa dòng, và khi đã thụt
vim.opt.backspace = { "start", "eol", "indent" }

-- Cho phép tìm file trong thư mục con
vim.opt.path:append({ "**" })

-- Bỏ qua thư mục node_modules khi tìm kiếm
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Mở cửa sổ mới ở dưới và bên phải
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Khi chia cửa sổ, giữ vị trí con trỏ
vim.opt.splitkeep = "cursor"

-- Tắt hỗ trợ chuột
--vim.opt.mouse = ""

-- Hiệu ứng gạch dưới cong (undercurl)
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Khi enter trong block comment sẽ tự thêm dấu *
vim.opt.formatoptions:append({ "r" })

-- Xác định loại file theo đuôi file
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- Với Neovim >= 0.8 thì ẩn thanh lệnh khi không dùng
if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end

-- Thêm định dạng file MDX
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- Chỉ bật Prettier nếu có config file
vim.g.lazyvim_prettier_needs_config = true

-- Chọn plugin tìm kiếm là Telescope
vim.g.lazyvim_picker = "telescope"

-- Chọn plugin completion là blink.cmp
vim.g.lazyvim_cmp = "blink.cmp"
