package com.darwinruiz.shoplite.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean ok = false;
        if (session != null) {
            Object authAttr = session.getAttribute("auth");
            Object roleAttr = session.getAttribute("role");
            boolean auth = (authAttr instanceof Boolean) && (Boolean) authAttr;
            String role = roleAttr != null ? roleAttr.toString() : null;
            ok = auth && "ADMIN".equals(role);
        }

        if (ok) {
            chain.doFilter(request, response);
        } else {
            RequestDispatcher rd = req.getRequestDispatcher("/403.jsp");
            rd.forward(req, resp);
        }
    }
}
