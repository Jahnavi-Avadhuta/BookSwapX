package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.ReportDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Report;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO implements ReportDAOInterface {

	public boolean fileReport(Report report) {
		String sql = "INSERT INTO reports (reporter_id, reported_user_id, reported_listing_id, reason, description) VALUES (?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, report.getReporterId());
			ps.setObject(2, report.getReportedUserId()); 
			ps.setObject(3, report.getReportedListingId()); 
			ps.setString(4, report.getReason());
			ps.setString(5, report.getDescription());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Report> getAllPendingReports() {
		List<Report> list = new ArrayList<>();
		String sql = "SELECT * FROM reports WHERE status = 'PENDING' ORDER BY created_at DESC";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next())
				list.add(mapReport(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateReportStatus(int reportId, String status) {
		String sql = "UPDATE reports SET status = ? WHERE report_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, reportId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private Report mapReport(ResultSet rs) throws SQLException {
		Report r = new Report();
		r.setReportId(rs.getInt("report_id"));
		r.setReporterId(rs.getInt("reporter_id"));
		r.setReportedUserId(rs.getInt("reported_user_id"));
		r.setReportedListingId(rs.getInt("reported_listing_id"));
		r.setReason(rs.getString("reason"));
		r.setDescription(rs.getString("description"));
		r.setStatus(rs.getString("status"));
		r.setCreatedAt(rs.getTimestamp("created_at"));
		return r;
	}
}