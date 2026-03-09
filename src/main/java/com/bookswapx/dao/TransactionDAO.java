package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.TransactionDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Transaction;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO implements TransactionDAOInterface {

	public boolean addTransaction(Transaction t) {
		String sql = "INSERT INTO transaction_history (listing_id, buyer_id, seller_id, book_id, transaction_type, price, is_exchange) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, t.getListingId());
			ps.setInt(2, t.getBuyerId());
			ps.setInt(3, t.getSellerId());
			ps.setInt(4, t.getBookId());
			ps.setString(5, t.getTransactionType());
			ps.setDouble(6, t.getPrice());
			ps.setBoolean(7, t.isExchange());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Transaction> getTransactionsByUser(int userId) {
		List<Transaction> transactions = new ArrayList<>();
		String sql = "SELECT t.*, b.title as book_title, b.author as book_author, " + "buyer.username as buyer_name, "
				+ "seller.username as seller_name " + "FROM transaction_history t "
				+ "JOIN books b ON t.book_id = b.book_id " + "JOIN users buyer ON t.buyer_id = buyer.user_id "
				+ "JOIN users seller ON t.seller_id = seller.user_id " + "WHERE t.buyer_id = ? OR t.seller_id = ? "
				+ "ORDER BY t.completed_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Transaction t = new Transaction();
				t.setTransactionId(rs.getInt("transaction_id"));
				t.setListingId(rs.getInt("listing_id"));
				t.setBuyerId(rs.getInt("buyer_id"));
				t.setSellerId(rs.getInt("seller_id"));
				t.setBookId(rs.getInt("book_id"));
				t.setTransactionType(rs.getString("transaction_type"));
				t.setPrice(rs.getDouble("price"));
				t.setExchange(rs.getBoolean("is_exchange"));
				t.setCompletedAt(rs.getTimestamp("completed_at"));
				t.setBookTitle(rs.getString("book_title"));
				t.setBookAuthor(rs.getString("book_author"));
				t.setBuyerName(rs.getString("buyer_name"));
				t.setSellerName(rs.getString("seller_name"));
				transactions.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return transactions;
	}

	private Transaction mapTransaction(ResultSet rs) throws SQLException {
		Transaction t = new Transaction();
		t.setTransactionId(rs.getInt("transaction_id"));
		t.setListingId(rs.getInt("listing_id"));
		t.setBuyerId(rs.getInt("buyer_id"));
		t.setSellerId(rs.getInt("seller_id"));
		t.setBookId(rs.getInt("book_id"));
		t.setTransactionType(rs.getString("transaction_type"));
		t.setPrice(rs.getDouble("price"));
		t.setExchange(rs.getBoolean("is_exchange"));
		t.setCompletedAt(rs.getTimestamp("completed_at"));
		return t;
	}
}