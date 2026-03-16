<%-- 
    Document   : viewDetail
    Created on : Mar 12, 2026, 3:12:43 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Detail</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewDetail.css">
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
            <div class="detail-layout">
                <div class="detail-image-box">
                    <img src="images/${product.imgURL}" alt="${product.productName}">
                </div>

                <div class="detail-info-box">
                    <h1 class="detail-product-name">${product.productName}</h1>
                    <div class="product-meta">
                        <p>Mã sản phẩm: <strong>#${product.productID}</strong></p>

                        <p>Loại: <span class="badge-type">${product.productType}</span></p>

                        <p>Trạng thái: <span class="status">${product.status}</span></p>
                    </div>

                    <div class="detail-price price">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ"/>
                    </div>

                    <div class="detail-description">
                        <h3>Mô tả sản phẩm:</h3>
                        <p>${product.description}</p>
                    </div>

                    <form action="CartServlet" method="post" class="add-to-cart-form">
                        <input type="hidden" name="productID" value="${product.productID}">
                        <input type="hidden" name="action" value="add">

                        <div class="quantity-input-group">
                            <label>Số lượng: </label>
                            <input type="number" name="quantity" value="1" min="1" max="10">
                        </div>

                        <div class="purchase-section">
                            <c:choose>
                                <c:when test="${product.status == true}">
                                    <button type="submit" class="btn-add-to-cart">
                                        THÊM VÀO GIỎ HÀNG
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <button type="button" class="btn-disabled" disabled>
                                        TẠM HẾT HÀNG
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </form>

                    <div class="back-link-wrapper">
                        <a href="KhoGaServlet" class="back-link">← Quay lại danh sách</a>
                    </div>
                </div>
            </div>
        </div>
                        <jsp:include page="footer.jsp" />
    </body>
</html>
