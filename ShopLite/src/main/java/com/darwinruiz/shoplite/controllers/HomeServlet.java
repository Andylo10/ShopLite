package com.darwinruiz.shoplite.controllers;

import com.darwinruiz.shoplite.models.Product;
import com.darwinruiz.shoplite.repositories.ProductRepository;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final ProductRepository repo = new ProductRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            List<Product> all = repo.findAll();

            int size = parseInt(req.getParameter("size"), 3); // tamaño por defecto = 3
            if (size < 1) size = 3;

            int total = all.size();
            int totalPages = (int) Math.ceil(total / (double) size);
            if (totalPages == 0) totalPages = 1;

            int page = parseInt(req.getParameter("page"), 1);
            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;

            int fromIndex = Math.min((page - 1) * size, total);
            int toIndex = Math.min(fromIndex + size, total);

            List<Product> items = new ArrayList<>();
            if (fromIndex < toIndex) {
                items = all.subList(fromIndex, toIndex);
            }

            req.setAttribute("items", items);
            req.setAttribute("page", page);
            req.setAttribute("size", size);
            req.setAttribute("total", total);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("hasPrev", page > 1);
            req.setAttribute("hasNext", page < totalPages);

            req.getRequestDispatcher("/home.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new IOException(e);
        }
    }

    private int parseInt(String s, int def) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return def;
        }
    }
}
