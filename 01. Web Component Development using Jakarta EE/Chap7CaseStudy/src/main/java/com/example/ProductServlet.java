package com.example;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        double price = priceStr != null ? Double.parseDouble(priceStr) :
                0.0;
        HttpSession session = req.getSession();
        List<Product> products = (List<Product>)
                session.getAttribute("products");
        if (products == null) {
            products = new ArrayList<>();
        }
        products.add(new Product(name, price));
        session.setAttribute("products", products);
        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/products.jsp");
        dispatcher.forward(req, resp);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<Product> products = (List<Product>) session.getAttribute("products");

        // ✅ Xử lý xóa nếu có deleteIndex
        String deleteIndexStr = req.getParameter("deleteIndex");
        if (deleteIndexStr != null && products != null) {
            try {
                int index = Integer.parseInt(deleteIndexStr);
                if (index >= 0 && index < products.size()) {
                    products.remove(index); // Xóa sản phẩm
                    session.setAttribute("products", products); // Cập nhật lại
                }
            } catch (NumberFormatException e) {
                System.out.println("Lỗi: deleteIndex không hợp lệ");
            }
        }

        // ✅ Server Push CSS nếu dùng HTTP/2
        PushBuilder pushBuilder = req.newPushBuilder();
        if (pushBuilder != null) {
            pushBuilder.path("css/style.css").addHeader("Content-Type", "text/css").push();
        }

        // ✅ Hiển thị lại danh sách sản phẩm
        RequestDispatcher dispatcher = req.getRequestDispatcher("/products.jsp");
        dispatcher.forward(req, resp);
    }
}
