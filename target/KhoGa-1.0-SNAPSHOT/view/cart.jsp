<%-- 
    Document   : cart
    Created on : Mar 12, 2026, 10:01:12 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cart.css">
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

        <div class="main-container">
            <h2 class="cart-title">Giỏ hàng của bạn</h2>

            <c:choose>
                <c:when test="${empty carts}">
                    <div class="empty-cart">
                        <p>Giỏ hàng đang trống!</p>
                        <a href="KhoGaServlet" class="btn-back">Quay lại mua sắm ngay</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Ảnh</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${carts}">
                                
                                <tr>
                                    <td class="p-name">${item.product.productName}</td>
                                    <td><img src="images/${item.product.imgURL}" class="cart-img"></td>
                                    <td class="p-price"><fmt:formatNumber value="${item.product.price}" pattern="#,###"/> VNĐ</td>
                                    <td>
                                        <form action="CartServlet" method="post" class="update-qty">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productID" value="${item.product.productID}">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" onchange="this.form.submit()">
                                        </form>
                                    </td>
                                    <td class="p-subtotal">
                                        <fmt:formatNumber value="${item.amount}" pattern="#,###"/> VNĐ
                                    </td>
                                    <td>
                                        <a href="CartServlet?action=delete&productID=${item.product.productID}" class="btn-delete">Xóa</a>
                                    </td>
                                </tr>
                                
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="cart-summary">
                        <div class="total-box">
                            <span>Tổng cộng:</span>
                            <span class="total-amount"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> VNĐ</span>
                        </div>
                        <div class="cart-actions">
                            <a href="KhoGaServlet" class="btn-continue">Mua tiếp</a>
                            <a href="CheckOutServlet" class="btn-checkout">Thanh toán ngay</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
                    <jsp:include page="footer.jsp" />
    </body>
</html>
