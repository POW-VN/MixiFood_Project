<%-- 
    Document   : admin
    Created on : Mar 14, 2026, 11:56:47 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css">
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

                    <a href="LogoutServlet" class="auth-btn logout">Đăng xuất</a>
                </div>
            </div>
        </header>
        <div class="admin-container">
            <div class="admin-title">
                <h2><i class="fas fa-clipboard-list"></i> DANH SÁCH ĐƠN HÀNG</h2>
                <span>Tổng số: ${listOrder.size()} đơn</span>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Mã ĐH</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Địa chỉ giao</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${listOrder}">
                        <tr>
                            <td><strong>#${o.orderID}</strong></td>
                            <td>${o.customer.customerName}</td>
                            <td>${o.formattedDate}</td>
                            <td style="color: #be1e2d; font-weight: bold;">${o.totalAmount} VNĐ</td>
                            <td><small>${o.address}</small></td>
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
                                <div style="display: flex; gap: 5px;">
                                    <a href="AdminServlet?action=adminDetail&id=${o.orderID}" class="btn-action btn-view">Xem</a>

                                    <c:if test="${o.status == 0}">
                                        <a href="AdminServlet?action=updatestatus&id=${o.orderID}&status=1" 
                                           class="btn-action btn-approve" 
                                           onclick="return confirm('Xác nhận nhận đơn hàng này?')">Duyệt</a>
                                    </c:if>

                                    <c:if test="${o.status == 1}">
                                        <a href="AdminServlet?action=updatestatus&id=${o.orderID}&status=2" 
                                           class="btn-action btn-finish" 
                                           style="background-color: #28a745;"
                                           onclick="return confirm('Xác nhận đơn hàng đã giao xong?')">Xong</a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
            <jsp:include page="footer.jsp" />
    </body>
</html>
