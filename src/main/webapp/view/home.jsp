<%-- 
    Document   : home
    Created on : Mar 12, 2026, 12:37:00 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.acc == null}">
    <c:redirect url="/view/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
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
        
        <main>
            <div class="filter-bar">
            <span>Lọc theo: </span>
            <a href="KhoGaServlet" class="filter-item">Tất cả</a>

            <c:forEach var="typeName" items="${allTypes}">
                <a href="KhoGaServlet?action=filter&type=${typeName}" class="filter-item">
                    ${typeName}
                </a>
            </c:forEach>
        </div>
            <h2>Danh sách sản phẩm</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${products}">
                    <a href="KhoGaServlet?action=viewDetail&productID=${p.productID}">
                    <div class="product-item">
                        <img src="images/${p.imgURL}" alt="${p.productName}" width="150">

                        <h3>${p.productName}</h3>

                        <p class="price">
                            Giá: <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ"/>
                        </p>


                    </div>
                    </a>
                </c:forEach>
            </div>
        </main>
                    <jsp:include page="footer.jsp" />
    </body>
</html>
