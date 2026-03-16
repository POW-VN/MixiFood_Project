<%-- 
    Document   : thankyou
    Created on : Mar 14, 2026, 2:21:33 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thank You</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/thankyou.css">
    </head>
    <body>
        <div class="thankyou-container">
            <div class="success-icon">✔</div>
            <h1>ĐẶT HÀNG THÀNH CÔNG!</h1>
            <p>Cảm ơn <strong>${sessionScope.acc.customerName}</strong> đã tin tưởng lựa chọn Mixi Food.<br>
            Đơn hàng của bạn đang được xử lý và sẽ sớm giao đến địa chỉ của bạn.</p>
            
            <div class="order-info">
                <span>Chúng tôi sẽ liên hệ với bạn qua số điện thoại: </span>
                <strong>${sessionScope.acc.customerPhone}</strong>
            </div>

            <a href="KhoGaServlet" class="btn-home">TIẾP TỤC MUA SẮM</a>
        </div>
            <jsp:include page="footer.jsp" />
    </body>
</html>
