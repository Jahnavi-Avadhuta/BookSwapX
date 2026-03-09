package com.bookswapx.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.bookswapx.dao.interfaces.CategoryDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Category;

public class CategoryDAO implements CategoryDAOInterface {

	public List<Category> getAllCategories() {
		List<Category> categories = new ArrayList<>();
		String sql = "SELECT * FROM categories";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Category cat = new Category();
				cat.setCategoryId(rs.getInt("category_id"));
				cat.setCategoryName(rs.getString("category_name"));
				categories.add(cat);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return categories;
	}

	public boolean addCategory(String categoryName) {
		String sql = "Insert into categories(category_name) values (?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, categoryName);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deleteCategory(int categoryId) {
		String sql = "Delete from categories where category_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, categoryId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
