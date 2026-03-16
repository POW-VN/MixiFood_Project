# 🍗 Mixi Food Project - PRJ301

Dự án website quản lý và đặt mua đồ ăn khô (Gà khô, Bò khô...) được thực hiện bằng Java Web.

## 🚀 Công nghệ sử dụng
* **Backend:** Java Servlet, JSP, JSTL.
* **Database:** SQL Server (JDBC).
* **Frontend:** HTML5, CSS3, JavaScript.
* **Công cụ:** NetBeans 25, Maven, Tomcat 10.

## 🛠️ Hướng dẫn cài đặt
1.  **Database:** * Mở SQL Server Management Studio.
    * Chạy file `sql.sql` có sẵn trong repo này để tạo bảng và dữ liệu mẫu.
2.  **Cấu hình:** * Mở project bằng NetBeans.
    * Sửa thông tin Connection (User/Pass SQL) trong class `DBUtils.java` hoặc `DBContext.java`.
3.  **Run:** Chuột phải vào Project chọn **Run**.

## ✨ Các chức năng chính
* [x] Đăng nhập/Đăng ký.
* [x] Xem danh sách và chi tiết món ăn.
* [x] Giỏ hàng (Thêm/Sửa/Xóa).
* [x] Đặt hàng & Quản lý đơn hàng cá nhân (Profile).
* [x] Admin: Duyệt đơn, cập nhật trạng thái, chỉnh sửa đơn hàng (Status 0).
* [x] Hủy đơn hàng.
