package com.example.chap7practice;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;
@WebFilter("/hello")
public class LogFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, jakarta.servlet.ServletException {
        long startTime = System.currentTimeMillis();
        System.out.println("Request start: " + startTime);
        chain.doFilter(request, response);
        long endTime = System.currentTimeMillis();
        System.out.println("Request end: " + endTime + ", Process time: " + (endTime - startTime) + "ms");
    }
}