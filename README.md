# JobLinks Project

JobLinks là website kết nối người có nhu cầu thuê người làm việc vặt (task) với người có thể nhận việc, gồm các chức năng như đăng task, xem danh sách task, ứng tuyển, thanh toán và nhắn tin.

---

## 👨‍💻 Thành viên và nhánh được phân công

| Thành viên | Nhánh Git | Chức năng |
|------------|-----------|-----------|
| A          | `feature-task-posting`  | Đăng task |
| B          | `feature-task-list`     | Xem danh sách task |
| C          | `feature-apply-task`    | Ứng tuyển task |
| D          | `feature-payment`       | Thanh toán |
| E          | `feature-chat`          | Nhắn tin giữa người thuê và người làm |

---

## 🚀 Cách làm việc với Git

### 1. Clone repository về máy (chỉ 1 lần)
```bash
git clone https://github.com/your-username/JobLinks.git
cd JobLinks
2. Chuyển sang nhánh được giao
bash
Sao chép
Chỉnh sửa
git fetch origin
git checkout -b <tên-nhánh> origin/<tên-nhánh>
Ví dụ:

bash
Sao chép
Chỉnh sửa
git checkout -b feature-task-posting origin/feature-task-posting
3. Code → Commit → Push
bash
Sao chép
Chỉnh sửa
git add .
git commit -m "Mô tả nội dung cập nhật"
git push
4. Tạo Pull Request (PR)
Truy cập GitHub → chọn nhánh bạn đang làm

Nhấn "Compare & pull request"

Chọn nhánh đích là main hoặc dev

Ghi mô tả nội dung chức năng đã hoàn thành

Nhấn "Create Pull Request"

🔁 Một số lưu ý khi làm việc nhóm
Luôn pull trước khi code để tránh xung đột:

bash
Sao chép
Chỉnh sửa
git pull origin <tên-nhánh>
Không push trực tiếp lên main

Mỗi thành viên chỉ code trong nhánh của mình

Viết commit message rõ ràng, ví dụ: "Hoàn thiện giao diện form đăng task"
