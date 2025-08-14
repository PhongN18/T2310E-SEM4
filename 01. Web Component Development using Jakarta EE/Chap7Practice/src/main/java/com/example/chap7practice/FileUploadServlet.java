package com.example.chap7practice;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
@WebServlet("/upload")
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws ServletException, IOException {
        Part filePart = req.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        long fileSize = filePart.getSize();
        req.setAttribute("fileName", fileName);
        req.setAttribute("fileSize", fileSize);
        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/result.jsp");
        dispatcher.forward(req, resp);
    }
}
