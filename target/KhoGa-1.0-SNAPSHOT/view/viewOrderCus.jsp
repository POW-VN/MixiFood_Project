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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewOrderCus.css">
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

           
                <form action="ProfileServlet" method="POST">
                    <input type="hidden" name="action" value="updateOrderUser">
                    <input type="hidden" name="id" value="${order.orderID}">
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
                    <c:choose>
                        <c:when test="${order.status == 0}">
                            <input type="text" name="address" value="${order.address}" class="input-editable">
                        </c:when>
                        <c:otherwise>
                            <p>${order.address}</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="info-item">
                    <h4>Ghi chú</h4>
                    <c:choose>
                        <c:when test="${order.status == 0}">
                            <textarea name="note" class="textarea-editable" rows="3">${order.note}</textarea>
                        </c:when>
                        <c:otherwise>
                            <p>${order.note}</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${order.status == 0}">
                    <div style="text-align: right; margin-top: 10px;">
                        <button type="submit" class="btn-update-info">Lưu thay đổi</button>
                    </div>
                </c:if>
                </div>
                </form>
            

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
            <c:if test="${order.status == 0}">
                <div class="cancel-section" style="margin-top: 40px; text-align: center;">
                    <p style="color: #666; font-size: 0.9em; margin-bottom: 10px;">Bạn muốn thay đổi ý định?</p>
                    <a href="ProfileServlet?action=updatestatus&id=${order.orderID}&status=-1" 
                       class="btn-cancel-order" 
                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')">
                       HỦY ĐƠN HÀNG
                    </a>
                </div>
            </c:if>
        </div>
            <jsp:include page="footer.jsp" />
    </body>
</html>
