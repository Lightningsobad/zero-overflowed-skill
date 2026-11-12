# Zero Overflowed Skill — Kế hoạch phát hành

## Mục tiêu v0.1

Giúp coding agent viết, kiểm tra và sửa layout Flutter trên Android và iOS. Mỗi kết luận phải dựa trên các ca đã chạy trong phạm vi mà ứng dụng cam kết hỗ trợ. Người dùng mới có thể cài skill từ GitHub và tái hiện một lỗi bằng app mẫu.

## Phạm vi kiểm tra của ứng dụng

Dùng thông số sẵn có của dự án. Cung cấp mẫu khai báo trong tài liệu để maintainer ghi chiều rộng và chiều cao logic tối thiểu theo hướng màn hình, cỡ chữ được hỗ trợ, locale, RTL nếu có, và các luồng cần kiểm tra với bàn phím hoặc system insets. Nếu dự án chưa công bố phạm vi, chạy ca thăm dò và ghi các giả định vào báo cáo.

Mỗi phần UI thay đổi có một ca cơ sở và các ca biên liên quan. Ưu tiên tổ hợp vùng chứa hẹp, chữ lớn và nội dung dài. Với component dùng lại, giới hạn kích thước ở parent trong widget test. Với form, dialog hoặc bottom sheet, kiểm tra cả khi không gian dọc bị giảm. Chạy trên emulator, simulator hoặc thiết bị khi ca kiểm tra cần bàn phím, insets hoặc hành vi hệ điều hành thực tế.

| Trạng thái | Điều kiện |
| --- | --- |
| `PASS` | Ca đã chạy và mọi kỳ vọng về layout, nội dung và thao tác đều đạt. |
| `FAIL` | Ca đã chạy và phát hiện lỗi layout, nội dung bắt buộc bị mất hoặc thao tác bắt buộc thất bại. |
| `NOT VERIFIED` | Ca bắt buộc chưa chạy hoặc chưa thu được bằng chứng cho kỳ vọng cần xác nhận. |

Ghi kèm component hoặc màn hình, cấu hình, dữ liệu, thao tác, lệnh test và kết quả. Chỉ báo phạm vi đã xác minh đầy đủ khi mọi ca bắt buộc đều `PASS`.

## Cấu trúc repo dự kiến

```text
README.md
LICENSE
CONTRIBUTING.md
CHANGELOG.md
skills/
  zero-overflowed/
    SKILL.md
    references/
      flutter-layout.md
      flutter-testing.md
docs/
  installation/
    claude-code.md
    codex.md
    antigravity.md
  usage.md
  support-matrix.md
examples/
  overflow_lab/
```

`SKILL.md` theo chuẩn Agent Skills và điều hướng ba chế độ viết, kiểm tra và sửa UI. Đóng gói toàn bộ thư mục `skills/zero-overflowed/`, gồm các tài liệu tham chiếu. Manifest plugin có thể dùng chung nội dung này khi cách phân phối của công cụ yêu cầu. Đề xuất README chính bằng tiếng Anh để cộng đồng quốc tế sử dụng, kèm quickstart tiếng Việt. Chốt giấy phép trước khi publish.

## Tích hợp và hướng dẫn sử dụng

| Công cụ | Đường dẫn skill trong app Flutter | Xác minh sau khi cài |
| --- | --- | --- |
| Claude Code | `.claude/skills/zero-overflowed/` | Gọi `/zero-overflowed` với prompt kiểm tra app mẫu. |
| Codex CLI và app | `.agents/skills/zero-overflowed/` | Chọn skill trong giao diện hoặc gọi `$zero-overflowed` rồi chạy ca mẫu. |
| Antigravity App, CLI và IDE | `.agents/skills/zero-overflowed/` | Kiểm tra mục Customizations hoặc `/skills` tùy môi trường, rồi chạy ca mẫu. |

Mỗi trang hướng dẫn cần có điều kiện cài đặt, lệnh copy cho PowerShell và Bash, phạm vi dự án và người dùng, cách xác nhận đã nạp đúng phiên bản, prompt mẫu, cách cập nhật và gỡ, và xử lý lỗi cài đặt. README dẫn tới từng trang và đưa người dùng thẳng đến ca chạy thử đầu tiên. Tài liệu sử dụng có ví dụ cho cả ba chế độ, gồm một báo cáo `FAIL` trước khi sửa và `PASS` sau khi chạy lại.

Ưu tiên cài thủ công từ tag phát hành làm đường dẫn chung. Với bản plugin, kiểm tra quy trình cài, cập nhật và gỡ trên từng công cụ có manifest trước khi đưa lệnh vào README. Xem xét Cursor, GitHub Copilot và OpenCode sau ba tích hợp chính. Ma trận hỗ trợ ghi từng môi trường, phiên bản, hệ điều hành, cách cài, ngày thử và kết quả. Mục mới đối chiếu tài liệu ghi rõ trạng thái chưa chạy thử.

## Kiểm chứng trước khi phát hành

1. **Tạo app mẫu có ca lỗi tái hiện được.** Bao gồm `RenderFlex` tràn ngang, nội dung bị cắt khi Flutter không báo exception, form bị bàn phím che, bottom sheet thiếu chiều cao, và carousel cuộn ngang hợp lệ. Với từng ca lỗi, cùng một kỳ vọng phải thất bại trên bản lỗi và đạt trên bản sửa. Ca hợp lệ phải đạt để kiểm tra báo sai.
2. **Chạy test tự động.** GitHub Actions kiểm tra cấu trúc skill, liên kết nội bộ và widget test của app mẫu. Kiểm tra ca cần Android/iOS thực tế bằng quy trình riêng, lưu cấu hình và kết quả vào ma trận. Mỗi hướng dẫn cài đặt phải được thử trong một dự án Flutter mới trên môi trường mà tài liệu tuyên bố hỗ trợ.
3. **Đánh giá hành vi agent.** Giao cùng bài tập với cùng model và cấu hình, có và không có skill. Công bố prompt, phiên bản, số lượt chạy, số lỗi bắt được, số báo sai, số lần sửa làm mất nội dung hoặc thao tác, và số lần agent báo đã xác minh khi thiếu bằng chứng.
4. **Phát hành bản có thể tái hiện.** Gắn tag `v0.1.0`, ghi rõ phiên bản Flutter đã kiểm thử, thêm mẫu GitHub Issue cho lỗi cài đặt hoặc lỗi overflow bị bỏ sót. Mẫu lỗi overflow yêu cầu thông số viewport, cỡ chữ, locale, trạng thái bàn phím và ca tái hiện tối thiểu.

## Tài liệu tham chiếu

- [Đặc tả Agent Skills](https://agentskills.io/specification)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Cài skill cấp dự án hoặc cấp người dùng trong Codex](https://developers.openai.com/api/reference/cli)
- [Đóng gói plugin cho Codex](https://developers.openai.com/plugins/build/plugins)
- [Antigravity Agent Skills](https://antigravity.google/docs/skills)
- [Superpowers](https://github.com/obra/superpowers)
- [Ponytail](https://github.com/DietrichGebert/ponytail)
