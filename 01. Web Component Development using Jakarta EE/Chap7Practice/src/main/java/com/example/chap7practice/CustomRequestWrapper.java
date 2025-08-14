package com.example.chap7practice;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
public class CustomRequestWrapper extends HttpServletRequestWrapper {
    public CustomRequestWrapper(HttpServletRequest request) {
        super(request);
    }
    @Override
    public String getHeader(String name) {
        if ("X-Custom-Header".equals(name)) {
            return "CustomValue";
        }
        return super.getHeader(name);
    }
}
