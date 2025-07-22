package com.example;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
@WebServlet("/add-product")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws IOException {
        resp.setContentType("text/html; charset=UTF-8");
        String sessionId = req.getParameter("sessionId");
        if (sessionId == null || sessionId.isEmpty()) {
            sessionId = UUID.randomUUID().toString();
        }
        String productName = req.getParameter("productName");
        PrintWriter out = resp.getWriter();
        out.println("<html><body>");
        out.println("<h1>Sản phẩm đã thêm</h1>");
        out.println("<p>Session ID: " + sessionId + "</p>");
        out.println("<p>Tên sản phẩm: " + (productName != null ?
                productName : "Chưa nhập") + "</p>");
        out.println("<a href='" + resp.encodeURL("form.html?sessionId=" +
                sessionId) + "'>Thêm sản phẩm khác</a>");
        out.println("</body></html>");
    }
}
