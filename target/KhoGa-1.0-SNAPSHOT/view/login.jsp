<%-- 
    Document   : login
    Created on : Mar 13, 2026, 12:09:29 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
    </head>
    <body>
        
        <div class="login-page">
            <div class="login-box">
                <h2>Đăng nhập</h2>
                
                <c:if test="${not empty sessionScope.successMsg}">
                    <div class="success-alert" style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px; border: 1px solid #c3e6cb;">
                        ${sessionScope.successMsg}
                    </div>
                    <%-- Xóa thông báo ngay sau khi hiển thị để F5 không hiện lại --%>
                    <c:remove var="successMsg" scope="session" />
                </c:if>
    
                <c:if test="${not empty error}">
                    <div class="error-msg">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                    <input type="text" name="user" placeholder="Tên đăng nhập" required>
                    <input type="password" name="pass" placeholder="Mật khẩu" required>
                    <button type="submit" class="btn-login">Vào ngay</button>
                </form>

                <p style="margin-top: 20px; font-size: 14px;">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/view/register.jsp" style="color: #be1e2d; text-decoration: none; font-weight: bold;">Đăng ký</a>
                </p>
            </div>
        </div>
    </body>
</html>
