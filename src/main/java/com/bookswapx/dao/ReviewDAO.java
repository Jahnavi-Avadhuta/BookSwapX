package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.ReviewDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO implements ReviewDAOInterface {

	public boolean addReview(Review review) {
		String sql = "INSERT INTO reviews (reviewer_id, reviewed_user_id, rating, comment) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, review.getReviewerId());
			ps.setInt(2, review.getReviewedUserId());
			ps.setInt(3, review.getRating());
			ps.setString(4, review.getComment());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Review> getReviewsForUser(int userId) {
		List<Review> list = new ArrayList<>();
		String sql = "SELECT * FROM reviews WHERE reviewed_user_id = ? ORDER BY created_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(mapReview(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public double getAverageRating(int userId) {
		String sql = "SELECT AVG(rating) FROM reviews WHERE reviewed_user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getDouble(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0.0;
	}

	private Review mapReview(ResultSet rs) throws SQLException {
		Review r = new Review();
		r.setReviewId(rs.getInt("review_id"));
		r.setReviewerId(rs.getInt("reviewer_id"));
		r.setReviewedUserId(rs.getInt("reviewed_user_id"));
		r.setRating(rs.getInt("rating"));
		r.setComment(rs.getString("comment"));
		r.setCreatedAt(rs.getTimestamp("created_at"));
		return r;
	}
}