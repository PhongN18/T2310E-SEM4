<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Giỏ Hàng</title>
</head>
<body>
<h1>Giỏ hàng của bạn</h1>
<ul>
    <c:forEach items="${sessionScope.cart}" var="product">
        <li>${product}</li>
    </c:forEach>
</ul>
<a href="cart.html">Thêm sản phẩm</a>
<a href="logout">Đăng xuất</a>
</body>
</html>