return {
	-- Tùy chỉnh các nhãn (labels) được sử dụng
	labels = "abcdefghijklmnopqrstuvwxyz",
	-- Kích hoạt các chế độ flash
	modes = {
		search = {
			enabled = true, -- Flash khi tìm kiếm (tích hợp / và ?)
		},
		char = {
			enabled = true,
		},
		treesitter = {
			enabled = true, -- Flash dựa trên cú pháp Treesitter
		},
		remote = {
			enabled = true, -- Flash từ các cửa sổ khác (ví dụ: Telescope)
		},
	},
	-- Khuyến nghị thêm: Keymaps (chắc chắn bạn đã map <C-s> hoặc r/R ở đâu đó)
	-- mappings = {
	--     search = "s",  -- Khởi chạy Flash Search
	--     remote = "R",  -- Khởi chạy Flash Remote
	--     jump = { "f", "t", "F", "T" }, -- Tích hợp f/t/F/T (mặc định đã bật)
	-- },
}
