<%-- 
    Document   : checkout
    Created on : Mar 14, 2026, 12:03:03 AM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/checkOut.css">
    </head>
    <body>
        <div class="checkout-wrapper">
            <div class="checkout-left">
                <h2>Thông tin giao hàng</h2>
                <form action="CheckOutServlet" method="post">
                   <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="name" value="${sessionScope.acc.customerName}" readonly class="input-disabled">
                    </div>

                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" value="${sessionScope.acc.customerPhone}" readonly class="input-disabled">
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ nhận hàng *</label>
                        <input type="text" name="address" required placeholder="Số nhà, tên đường, phường/xã...">
                    </div>
                    <div class="form-group">
                        <label>Ghi chú đơn hàng</label>
                        <textarea name="note" rows="3" placeholder="Ghi chú về thời gian giao hàng..."></textarea>
                    </div>
                    <div class="payment-methods">
                        <h4>Phương thức thanh toán</h4>
                        <input type="radio" name="paymentMethod" value="COD" checked onclick="toggleQR(false)"> Thanh toán khi nhận hàng (COD) <br>
                        <input type="radio" name="paymentMethod" value="ATM" onclick="toggleQR(true)"> Chuyển khoản qua ATM/Ngân hàng <br>

                        <div id="qr-container" style="display: none; margin-top: 20px; text-align: center; border: 1px dashed #be1e2d; padding: 10px;">
                            <p>Vui lòng quét mã QR để thanh toán:</p>
                            <img src="images/bank.jpg" alt="Mã QR Thanh Toán" style="width: 250px; height: auto;">
                            <p style="font-size: 0.9em; color: #555;">Nội dung CK: <strong>Thanh toán đơn hàng ${acc.customerName}</strong></p>
                        </div>
                    </div>

                    <script>
                    function toggleQR(show) {
                        const qrContainer = document.getElementById('qr-container');
                        if (show) {
                            qrContainer.style.display = 'block';
                        } else {
                            qrContainer.style.display = 'none';
                        }
                    }
                    </script>
                    <div style="display: flex; align-items: stretch; gap: 15px; margin-top: 30px;">
                        <button type="submit" class="btn-confirm" style="margin: 0; flex: 2;">
                            XÁC NHẬN ĐẶT HÀNG
                        </button>

                        <a href="CartServlet?action=list" class="btn-back-cart" style="margin: 0; flex: 1; display: flex; align-items: center; justify-content: center;">
                            Quay lại giỏ hàng
                        </a>
                    </div>
                </form>
            </div>

            <div class="checkout-right">
                <h3>Đơn hàng của bạn</h3>
                <c:forEach var="item" items="${carts}">
                    <div class="order-summary-item">
                        <span>${item.product.productName} x ${item.quantity}</span>
                        <span>${item.unitPrice * item.quantity} VNĐ</span>
                    </div>
                </c:forEach>

                <div class="total-row">
                    <span>Tổng cộng:</span>
                    <span>${cart.totalAmount} VNĐ</span>
                </div>
            </div>
        </div>
              <jsp:include page="footer.jsp" />  
    </body>
</html>
