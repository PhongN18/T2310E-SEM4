package com.example;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/upload")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // Giới hạn 5MB
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse
            resp) throws ServletException, IOException {
        try {
            Part filePart = req.getPart("file");
            String fileName = filePart.getSubmittedFileName();
            long fileSize = filePart.getSize();
// Lưu thông tin tệp vào ServletContext
            ServletContext context = getServletContext();
            List<String> uploadedFiles = (List<String>)
                    context.getAttribute("uploadedFiles");
            if (uploadedFiles == null) {
                uploadedFiles = new ArrayList<>();
            }
            uploadedFiles.add(fileName + " (" + fileSize + " bytes)");
            context.setAttribute("uploadedFiles", uploadedFiles);
// Chuyê ̉n tiê ́p đê ́n JSP
            req.setAttribute("fileName", fileName);
            req.setAttribute("fileSize", fileSize);
            RequestDispatcher dispatcher =
                    req.getRequestDispatcher("/result.jsp");
            dispatcher.forward(req, resp);
        }
        catch (Exception e) {
// Xư ̉ lý lô ̃i (ví dụ: tệp quá lớn)
            req.setAttribute("errorMessage", "Lô ̃i: " + e.getMessage());
            RequestDispatcher dispatcher =
                    req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);
        }
    }
}