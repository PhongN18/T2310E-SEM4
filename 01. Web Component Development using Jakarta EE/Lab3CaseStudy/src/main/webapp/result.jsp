<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Kê
        ́t qua ̉ Ta ̉i Tệp</title>
</head>
<body>
<h1>Tệp đã tải lên</h1>
<p>Tên tệp: ${fileName}</p>
<p>Kích thước: ${fileSize} bytes</p>
<h2>Danh sách tệp đã tải lên:</h2>
<ul>
    <c:forEach items="${applicationScope.uploadedFiles}" var="file">
        <li>${file}</li>
    </c:forEach>
</ul>
<a href="upload.html">Ta ̉i tệp khác</a>
</body>
</html>