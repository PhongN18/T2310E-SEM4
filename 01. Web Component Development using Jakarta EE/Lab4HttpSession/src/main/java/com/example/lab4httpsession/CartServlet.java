package com.example;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet({"/cart", "/logout"})
public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<String> cart = (List<String>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        String product = req.getParameter("product");
        if (product != null && !product.isEmpty()) {
            cart.add(product);
        }
        session.setAttribute("cart", cart);

        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/cart.jsp");
        dispatcher.forward(req, resp);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/logout".equals(path)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect("cart.html");
        } else {
            RequestDispatcher dispatcher =
                    req.getRequestDispatcher("/cart.jsp");
            dispatcher.forward(req, resp);
        }
    }
}