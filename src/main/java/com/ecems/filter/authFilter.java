/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.ecems.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebFilter(filterName = "authFilter", urlPatterns = {"/*"})
public class authFilter implements Filter {
    
    public authFilter() {
    }

    /**
     *
     * @param sr
     * @param sr1
     * @param fc
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1,
            FilterChain fc)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) sr;
        HttpServletResponse response = (HttpServletResponse) sr1;
        
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        String path = uri.substring(contextPath.length());
        
        // Public Path (Static Resources, e.g.: CSS, JS, etc )
        if (
                // Index
                path.equals("/") ||
                path.equals("/index") ||
                
                // Login or Register
                path.equals("/login") ||
                path.equals("/register") ||

                // Partials
                path.startsWith("/views/partials/")
            ) {
            fc.doFilter(request, response);
            return;
        }
        
        fc.doFilter(request, response);

    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
    }
 
}
