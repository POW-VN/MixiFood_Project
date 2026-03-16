<%-- 
    Document   : adminDetail
    Created on : Mar 15, 2026, 1:39:06 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Detail</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminDetail.css">
    </head>
    <body>
        <div class="detail-container">
            <div class="header-detail">
                <h2>CHI TIẾT ĐƠN HÀNG #${order.orderID}</h2>
                <c:choose>
                    <%-- Nếu là Admin (role 1) --%>
                    <c:when test="${sessionScope.acc.role == 1}">
                        <a href="AdminServlet" class="btn-back">Quay lại</a>
                    </c:when>
                    <%-- Nếu là Khách hàng (role 0) --%>
                    <c:otherwise>
                        <a href="ProfileServlet" class="btn-back">Quay lại</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <h4>Khách hàng</h4>
                    <p>${order.customer.customerName}</p>
                </div>
                <div class="info-item">
                    <h4>Ngày đặt</h4>
                    <p>${order.formattedDate}</p>
                </div>
                <div class="info-item">
                    <h4>Địa chỉ giao hàng</h4>
                    <p>${order.address}</p>
                </div>
                <div class="info-item">
                    <h4>Ghi chú</h4>
                    <p>${empty order.note ? "Không có ghi chú" : order.note}</p>
                </div>
            </div>

            <table class="product-table">
                <thead>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Sản phẩm</th>
                        <th>Giá lúc mua</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.orderDetailsList}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/images/${item.product.imgURL}" class="img-product">
                            </td>
                            <td>
                                <strong>${item.product.productName}</strong><br>
                                <small>ID: ${item.product.productID}</small>
                            </td>
                            <td>${item.unitPrice} VNĐ</td>
                            <td>x ${item.quantity}</td>
                            <td style="font-weight: bold;">${item.unitPrice * item.quantity} VNĐ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="total-section">
                <p>Tổng cộng thanh toán:</p>
                <span class="total-price">${order.totalAmount} VNĐ</span>
            </div>
            <%-- Thêm đoạn này vào bên dưới phần hiển thị tổng tiền hoặc trong header-detail --%>
            <div class="admin-actions" style="margin-top: 30px; text-align: right; border-top: 1px solid #eee; padding-top: 20px;">
                <c:choose>
                    <%-- Nếu đơn hàng đang chờ nhận (0) --%>
                    <c:when test="${order.status == 0}">
                        <a href="AdminServlet?action=updatestatus&id=${order.orderID}&status=1" 
                           class="btn-action" 
                           style="background-color: #007bff; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                           ✔ DUYỆT ĐƠN (NHẬN ĐƠN)
                        </a>
                    </c:when>

                    <%-- Nếu đơn hàng đang xử lý (1) --%>
                    <c:when test="${order.status == 1}">
                        <a href="AdminServlet?action=updatestatus&id=${order.orderID}&status=2" 
                           class="btn-action" 
                           style="background-color: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                           ✅ HOÀN TẤT ĐƠN HÀNG
                        </a>
                    </c:when>
                    <%-- Nếu đã xử lý xong (2) --%>
                    <c:when test="${order.status == 2}">
                        <span style="color: #28a745; font-weight: bold; font-size: 1.2em;">✨ ĐƠN HÀNG ĐÃ HOÀN THÀNH</span>
                    </c:when>

                    <%-- Nếu là đơn đã hủy (-1) --%>
                    <c:when test="${order.status == -1}">
                        <span style="color: #6c757d; font-weight: bold; font-size: 1.2em;">✖ ĐƠN HÀNG ĐÃ BỊ HỦY</span>
                    </c:when>

                    <%-- Trường hợp dự phòng nếu có lỗi logic --%>
                    <c:otherwise>
                        <span style="color: #666;">Trạng thái không xác định</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
            <jsp:include page="footer.jsp" />
    </body>
</html>
