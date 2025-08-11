package com.darwinruiz.shoplite.controllers;

import com.darwinruiz.shoplite.models.User;
import com.darwinruiz.shoplite.repositories.UserRepository;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Optional<User> optUser = userRepository.findByEmail(email);
        boolean valid = optUser.isPresent() && optUser.get().getPassword().equals(password);

        if (!valid) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?err=1");
            return;
        }

        // invalidar sesión anterior
        HttpSession old = req.getSession(false);
        if (old != null) {
            try { old.invalidate(); } catch (IllegalStateException ignored) {}
        }

        // crear nueva sesión
        HttpSession session = req.getSession(true);
        User u = optUser.get();
        session.setAttribute("auth", true);
        session.setAttribute("userEmail", u.getEmail());
        session.setAttribute("role", u.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 minutos

        resp.sendRedirect(req.getContextPath() + "/home");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
