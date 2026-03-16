<%-- 
    Document   : register
    Created on : Mar 13, 2026, 12:30:23 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
    </head>
    <body>
        <div class="login-page"> 
            <div class="login-box">
                <h2>Đăng ký thành viên</h2>

                <c:if test="${not empty error}">
                    <div class="error-msg">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                    <input type="text" name="name" placeholder="Họ và tên" required>
                    <input type="text" name="phone" placeholder="Số điện thoại" required>
                    <input type="text" name="user" placeholder="Tên đăng nhập" required>
                    <input type="password" name="pass" placeholder="Mật khẩu" required>
                    <input type="password" name="rePass" placeholder="Nhập lại mật khẩu" required>

                    <button type="submit" class="btn-login">Đăng ký ngay</button>
                </form>

                <p style="margin-top: 20px; font-size: 14px;">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/LoginServlet" style="color: #be1e2d; font-weight: bold;">Đăng nhập</a>
                </p>
            </div>
        </div>
    </body>
</html>
