package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.ExchangeDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.ExchangeRequest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExchangeDAO implements ExchangeDAOInterface {

	public boolean createRequest(ExchangeRequest request) {
		String sql = "INSERT INTO exchange_requests (match_id, requester_id) VALUES (?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, request.getMatchId());
			ps.setInt(2, request.getRequesterId());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateRequestStatus(int requestId, String status) {
		String sql = "UPDATE exchange_requests SET status = ?, responded_at = CURRENT_TIMESTAMP WHERE request_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, requestId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<ExchangeRequest> getRequestsForUser(int userId) {
		List<ExchangeRequest> list = new ArrayList<>();
		String sql = "SELECT er.* FROM exchange_requests er "
				+ "JOIN potential_matches pm ON er.match_id = pm.match_id "
				+ "WHERE pm.user_a_id = ? OR pm.user_b_id = ? " + "ORDER BY er.created_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(mapRequest(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public ExchangeRequest getRequestById(int requestId) {
		String sql = "SELECT * FROM exchange_requests WHERE request_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, requestId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return mapRequest(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public ExchangeRequest getRequestByMatchId(int matchId) {
		String sql = "SELECT * FROM exchange_requests WHERE match_id = ? " + "ORDER BY created_at DESC LIMIT 1";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, matchId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				ExchangeRequest er = new ExchangeRequest();
				er.setRequestId(rs.getInt("request_id"));
				er.setMatchId(rs.getInt("match_id"));
				er.setRequesterId(rs.getInt("requester_id"));
				er.setStatus(rs.getString("status"));
				er.setCreatedAt(rs.getTimestamp("created_at"));
				return er;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private ExchangeRequest mapRequest(ResultSet rs) throws SQLException {
		ExchangeRequest er = new ExchangeRequest();
		er.setRequestId(rs.getInt("request_id"));
		er.setMatchId(rs.getInt("match_id"));
		er.setRequesterId(rs.getInt("requester_id"));
		er.setStatus(rs.getString("status"));
		er.setCreatedAt(rs.getTimestamp("created_at"));
		er.setRespondedAt(rs.getTimestamp("responded_at"));
		er.setCompletedAt(rs.getTimestamp("completed_at"));
		return er;
	}
}