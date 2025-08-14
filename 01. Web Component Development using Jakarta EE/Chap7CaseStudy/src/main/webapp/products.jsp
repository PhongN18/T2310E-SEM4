<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh Sách Sản Phẩm</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h1>Danh sách sản phẩm</h1>
<table>
    <tr>
        <th>Tên</th>
        <th>Giá</th>
        <th>Ngày tạo</th>
        <th>Hành động</th>
    </tr>
    <c:forEach var="product" items="${sessionScope.products}">
        <tr>
            <td><c:out value="${product.name}"/></td>
            <td><c:out value="${product.price}"/></td>
            <td><c:out value="${product.formattedCreatedAt}"/></td>
            <td>
                <a href="product?deleteIndex=${status.index}" onclick="return confirm('Bạn có chắc chắn muốn xóa không?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>
<c:set var="total" value="0" />
<c:set var="count" value="0" />
<c:forEach var="product" items="${sessionScope.products}" varStatus="status">
    ...
    <c:set var="total" value="${total + product.price}" />
    <c:set var="count" value="${count + 1}" />
</c:forEach>

<p>Tổng số sản phẩm: ${count}</p>
<p>Tổng giá trị: ${total}</p>
<a href="product-form.html">Thêm sản phẩm</a>
</body>
</html>