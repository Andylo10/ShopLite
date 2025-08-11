package com.darwinruiz.shoplite.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class AuthFilter implements Filter {

    private static final Set<String> PUBLIC_URIS = Set.of(
            "/",
            "/index.jsp",
            "/login.jsp",
            "/auth/login",
            "/auth/logout" // permitir cerrar sesión aunque no haya sesión activa
    );

    private boolean isPublic(HttpServletRequest req) {
        String uri = req.getRequestURI();
        String ctx = req.getContextPath();
        if (ctx != null && !ctx.isEmpty() && uri.startsWith(ctx)) {
            uri = uri.substring(ctx.length());
        }
        if (PUBLIC_URIS.contains(uri)) return true;

        // permitir recursos estáticos
        return uri.startsWith("/assets/") || uri.startsWith("/static/")
                || uri.startsWith("/css/") || uri.startsWith("/js/")
                || uri.startsWith("/images/");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        if (isPublic(req)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        boolean authenticated = false;
        if (session != null) {
            Object authAttr = session.getAttribute("auth");
            authenticated = (authAttr instanceof Boolean) && (Boolean) authAttr;
        }

        if (authenticated) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}
