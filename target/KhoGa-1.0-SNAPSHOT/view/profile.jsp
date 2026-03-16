<%-- 
    Document   : profile
    Created on : Mar 15, 2026, 2:36:23 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
         <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/profile.css">
    </head>
    <body>
        <header>
            <div class="logo">
                <a href="${pageContext.request.contextPath}/KhoGaServlet">Mixi Food</a>
            </div>

            <div class="header-right">
                <div class="search-tool">
                    <form action="${pageContext.request.contextPath}/KhoGaServlet" method="get">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="query" placeholder="Tìm món khác...">
                        <button type="submit">Tìm kiếm</button>
                    </form>
                </div>

                <div class="cart-wrapper">
                    <a href="${pageContext.request.contextPath}/CartServlet" class="cart-link">
                        Giỏ hàng <span class="cart-count">${not empty carts ? carts.size() : 0}</span>
                    </a>
                </div>
              
                <div class="user-control">
                    <c:if test="${sessionScope.acc.role == 1}">
                        <a href="${pageContext.request.contextPath}/AdminServlet" class="auth-btn admin-btn" style="margin-right: 10px; background-color: #ffc107; color: black;">
                            Quản lý đơn hàng
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.acc.role == 0}">
                        <a href="${pageContext.request.contextPath}/ProfileServlet" class="auth-btn admin-btn" style="margin-right: 10px; background-color: #ffc107; color: black;">
                            Trang cá nhân
                        </a>
                    </c:if>

                    <a href="LogoutServlet" class="auth-btn logout">Đăng xuất</a>
                </div>
            </div>
        </header>
        <div class="profile-container">
        <div class="profile-left">
            <h2 class="profile-title">Thông tin của tôi</h2>
            <form action="ProfileServlet" method="POST">
                <input type="hidden" name="action" value="updateProfile">
                <div class="form-group">
                    <label>Họ và tên</label>
                    <input type="text" name="name" value="${sessionScope.acc.customerName}" required>
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="phone" value="${sessionScope.acc.customerPhone}" required>
                </div>
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <input type="text" name="username" value="${sessionScope.acc.username}" required>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <input type="text" name="password" value="${sessionScope.acc.password}" required>
                </div>
                <button type="submit" class="btn-update">CẬP NHẬT THÔNG TIN</button>
            </form>
            
            <c:if test="${not empty message}">
                <p style="color: green; margin-top: 10px; text-align: center;">${message}</p>
            </c:if>
        </div>

        <div class="profile-right">
            <h2 class="profile-title">Đơn hàng đã đặt</h2>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${userOrders}">
                        <tr>
                            <td><strong>#${o.orderID}</strong></td>
                            <td>${o.orderDate}</td>
                            <td style="color: #be1e2d; font-weight: bold;">${o.totalAmount} VNĐ</td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.status == 0}">
                                        <span class="status-badge status-0">Chờ nhận đơn</span>
                                    </c:when>
                                    <c:when test="${o.status == 1}">
                                        <span class="status-badge status-1">Đang xử lý</span>
                                    </c:when>
                                    <c:when test="${o.status == 2}">
                                        <span class="status-badge status-2">Đã hoàn tất</span>
                                    </c:when>
                                    <%-- Thêm trạng thái đã hủy --%>
                                    <c:when test="${o.status == -1}">
                                        <span class="status-badge status-cancelled">Đã hủy</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <a href="ProfileServlet?action=viewOrderCus&id=${o.orderID}" style="text-decoration: none; color: #007bff;">Xem chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userOrders}">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 20px;">Bạn chưa có đơn hàng nào. <a href="KhoGaServlet">Mua ngay!</a></td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
                <jsp:include page="footer.jsp" />
    </body>
</html>
