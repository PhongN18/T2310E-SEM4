package com.example;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
@WebServlet("/set-cookie")
public class CookieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws IOException {
        resp.setContentType("text/html; charset=UTF-8");
        String username = req.getParameter("username");

        // Tạo cookie
        Cookie cookie = new Cookie("username", username != null ? username
                : "Khách");
        cookie.setHttpOnly(true);
        cookie.setSecure(true);
        cookie.setMaxAge(3600); // Sống 1 giờ
        resp.addCookie(cookie);
// Hiển thị phản hồi
        PrintWriter out = resp.getWriter();
        out.println("<html><body>");
        out.println("<h1>Cookie đã được lưu!</h1>");
        out.println("<p>Tên người dùng: " + username + "</p>");
        out.println("<a href='set-cookie'>Xem cookie</a>");
        out.println("</body></html>");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.println("<html><body>");
        out.println("<h1>Cookie hiện tại:</h1>");

        // Đọc cookies
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    out.println("<p>Tên người dùng: " + cookie.getValue()
                            + "</p>");
                }
            }
        } else {
            out.println("<p>Không tìm thấy cookie!</p>");
        }
        out.println("<a href=''>Quay lại</a>");
        out.println("</body></html>");
    }
}
