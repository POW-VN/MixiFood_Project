<%-- 
    Document   : footer
    Created on : Mar 15, 2026, 9:30:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<footer class="main-footer">
    <div class="footer-container">
        <div class="footer-column">
            <div class="footer-logo">
                <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="Logo">
                <span class="brand-text">Mixi Food</span>
            </div>
            <p class="footer-desc">Tự hào mang đến những món gà ngon nhất, đậm đà hương vị truyền thống kết hợp hiện đại.</p>
        </div>

        <div class="footer-column">
            <h3>LIÊN HỆ</h3>
            <ul class="contact-info">
                <li><i class="fas fa-phone"></i> 0946189176</li>
                <li><i class="fas fa-envelope"></i> contact@mixifood.vn</li>
                <li><i class="fas fa-clock"></i> 08:00 - 22:00 (Hàng ngày)</li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>CHÍNH SÁCH</h3>
            <ul class="footer-links">
                <li><a href="#">Chính sách giao hàng</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Điều khoản dịch vụ</a></li>
            </ul>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>&copy; 2026 Mixi Food - Phát triển bởi <span style="color: #ffc107;">POW</span></p>
    </div>
</footer>
                <style>
                    .main-footer {
    background-color: #1a1a1a;
    color: #ffffff;
    padding: 50px 0 20px 0;
    margin-top: 50px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.footer-container {
    max-width: 1200px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    padding: 0 20px;
}

.footer-column h3 {
    color: #be1e2d;
    font-size: 1.2rem;
    margin-bottom: 20px;
    position: relative;
    padding-bottom: 10px;
}

.footer-column h3::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: 0;
    width: 50px;
    height: 2px;
    background-color: #be1e2d;
}

.footer-logo {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
}

.footer-logo img {
    height: 50px;
}

.footer-desc {
    color: #aaa;
    line-height: 1.6;
    font-size: 0.9rem;
}

.contact-info, .footer-links {
    list-style: none;
    padding: 0;
}

.contact-info li, .footer-links li {
    margin-bottom: 12px;
    color: #ccc;
    font-size: 0.9rem;
}

.footer-links li a {
    color: #ccc;
    text-decoration: none;
    transition: 0.3s;
}

.footer-links li a:hover {
    color: #be1e2d;
    padding-left: 5px;
}

.footer-bottom {
    text-align: center;
    margin-top: 40px;
    padding-top: 20px;
    border-top: 1px solid #333;
    font-size: 0.8rem;
    color: #777;
}
                </style>  
