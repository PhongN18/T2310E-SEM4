package com.example;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/counter")
public class CounterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ServletContext context = getServletContext();
        Integer count = (Integer) context.getAttribute("visitCount");
        if (count == null) {
            count = 1;
        }
        else {
            count++;
        }
        context.setAttribute("visitCount", count);
        req.setAttribute("currentCount", count);
        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/counter.jsp");
        dispatcher.forward(req, resp);
    }
}