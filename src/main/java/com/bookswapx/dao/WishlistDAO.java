package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.WishlistDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Wishlist;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO implements WishlistDAOInterface {

	@Override
	public boolean addToWishlist(int userId, int bookId) {
		String sql = "INSERT INTO wishlist (user_id, book_id) VALUES (?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, bookId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean removeFromWishlist(int userId, int bookId) {
		String sql = "DELETE FROM wishlist WHERE user_id = ? AND book_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, bookId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean isInWishlist(int userId, int bookId) {
		String sql = "SELECT 1 FROM wishlist WHERE user_id = ? AND book_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, bookId);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<Wishlist> getWishlistByUser(int userId) {
		List<Wishlist> wishlist = new ArrayList<>();
		String sql = "SELECT w.*, b.title, b.author, b.book_condition, " + "b.edition, b.isbn " + "FROM wishlist w "
				+ "JOIN books b ON w.book_id = b.book_id " + "WHERE w.user_id = ? " + "ORDER BY w.created_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Wishlist item = new Wishlist();
				item.setWishlistId(rs.getInt("wishlist_id"));
				item.setUserId(rs.getInt("user_id"));
				item.setBookId(rs.getInt("book_id"));
				item.setCreatedAt(rs.getTimestamp("created_at"));
				item.setBookTitle(rs.getString("title"));
				item.setBookAuthor(rs.getString("author"));
				item.setBookCondition(rs.getString("book_condition"));
				item.setBookEdition(rs.getString("edition"));
				item.setBookIsbn(rs.getString("isbn"));
				wishlist.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return wishlist;
	}
}