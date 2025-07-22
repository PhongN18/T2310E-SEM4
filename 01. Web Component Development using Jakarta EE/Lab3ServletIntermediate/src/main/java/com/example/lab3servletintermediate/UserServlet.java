package com.example;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
public class UserServlet extends HttpServlet {
    private String welcomeMessage;
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        welcomeMessage = config.getInitParameter("welcomeMessage");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws IOException {
        resp.setContentType("text/html; charset=UTF-8");
        String username = req.getParameter("username");
        PrintWriter out = resp.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + welcomeMessage + ", " + (username != null ?  username : "Khách") + "!</h1>");
        out.println("</body></html>");
    }
}