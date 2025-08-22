package com.darwinruiz.shoplite.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbAndreaConnection {

    private static DbAndreaConnection instance;
    private Connection connection;

    private static final String URL = "jdbc:postgresql://localhost:5433/appdb";
    private static final String USER = "postgres";
    private static final String PASSWORD = "admin123";

    private DbAndreaConnection() throws SQLException {
        this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static DbAndreaConnection getInstance() throws SQLException {
        if (instance == null || instance.getConnection().isClosed()) {
            instance = new DbAndreaConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}
