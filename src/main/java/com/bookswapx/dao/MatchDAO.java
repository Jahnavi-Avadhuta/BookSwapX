package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.MatchDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.PotentialMatch;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchDAO implements MatchDAOInterface {

	public List<PotentialMatch> getMatchesForUser(int userId) {
		List<PotentialMatch> matches = new ArrayList<>();
		String sql = "SELECT pm.*, " + "b1.title as book_a_title, b1.author as book_a_author, "
				+ "b2.title as book_b_title, b2.author as book_b_author, "
				+ "u1.username as user_a_name, u2.username as user_b_name " + "FROM potential_matches pm "
				+ "JOIN books b1 ON pm.book_a_id = b1.book_id " + "JOIN books b2 ON pm.book_b_id = b2.book_id "
				+ "JOIN users u1 ON pm.user_a_id = u1.user_id " + "JOIN users u2 ON pm.user_b_id = u2.user_id "
				+ "WHERE (pm.user_a_id = ? OR pm.user_b_id = ?) " + "AND pm.status IN ('PENDING', 'ACCEPTED') "
				+ "ORDER BY pm.match_date DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PotentialMatch match = new PotentialMatch();
				match.setMatchId(rs.getInt("match_id"));
				match.setUserAId(rs.getInt("user_a_id"));
				match.setUserBId(rs.getInt("user_b_id"));
				match.setBookAId(rs.getInt("book_a_id"));
				match.setBookBId(rs.getInt("book_b_id"));
				match.setStatus(rs.getString("status"));
				match.setMatchDate(rs.getTimestamp("match_date"));
				// Extra details
				match.setBookATitle(rs.getString("book_a_title"));
				match.setBookAAuthor(rs.getString("book_a_author"));
				match.setBookBTitle(rs.getString("book_b_title"));
				match.setBookBAuthor(rs.getString("book_b_author"));
				match.setUserAName(rs.getString("user_a_name"));
				match.setUserBName(rs.getString("user_b_name"));
				matches.add(match);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return matches;
	}

	public boolean updateMatchStatus(int matchId, String status) {
		String sql = "UPDATE potential_matches SET status = ? WHERE match_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, matchId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public PotentialMatch getMatchById(int matchId) {
		String sql = "SELECT * FROM potential_matches WHERE match_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, matchId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return mapMatch(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public int getListingIdByBookAndUser(int bookId, int userId) {
		String sql = "SELECT listing_id FROM listings WHERE book_id = ? AND user_id = ? AND status = 'AVAILABLE' AND is_deleted = false";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, bookId);
			ps.setInt(2, userId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getInt("listing_id");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	private PotentialMatch mapMatch(ResultSet rs) throws SQLException {
		PotentialMatch m = new PotentialMatch();
		m.setMatchId(rs.getInt("match_id"));
		m.setUserAId(rs.getInt("user_a_id"));
		m.setUserBId(rs.getInt("user_b_id"));
		m.setBookAId(rs.getInt("book_a_id"));
		m.setBookBId(rs.getInt("book_b_id"));
		m.setMatchDate(rs.getTimestamp("match_date"));
		m.setStatus(rs.getString("status"));
		return m;
	}
}