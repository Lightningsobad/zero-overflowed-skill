# Bắt đầu với Zero Overflowed

1. Mở dự án Flutter và kiểm tra `flutter --version`. Lấy bản checkout của repo Zero Overflowed.
2. Cài nguyên thư mục `skills/zero-overflowed/` theo hướng dẫn cho [Claude Code](installation/claude-code.md), [Codex](installation/codex.md) hoặc [Antigravity](installation/antigravity.md). Có lệnh cho PowerShell và Bash.
3. Khai báo kích thước tối thiểu, cỡ chữ, ngôn ngữ và các trạng thái app hỗ trợ. Dùng [mẫu và ví dụ](usage.md) để chỉ rõ nội dung phải đọc được và nút phải thao tác được.
4. Yêu cầu agent chạy test và báo từng ca `PASS`, `FAIL` hoặc `NOT VERIFIED`.

> Dùng zero-overflowed kiểm tra form thanh toán khi bàn phím mở trên viewport hẹp nhất được hỗ trợ. Hãy kiểm tra người dùng vẫn thấy trường đang nhập và cuộn tới nút gửi được. Ghi lại lệnh test, cấu hình và các ca chưa chạy.

Để thử lỗi có sẵn, mở [Overflow Lab](../examples/overflow_lab/README.md) và chạy cùng bộ test ở chế độ bình thường và chế độ `BROKEN_LAYOUTS=true`.
