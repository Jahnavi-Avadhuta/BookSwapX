package com.bookswapx.db;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnection {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                System.out.println("Connected!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}