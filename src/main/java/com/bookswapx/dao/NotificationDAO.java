package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.NotificationDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO implements NotificationDAOInterface {

	public List<Notification> getNotificationsForUser(int userId) {
		List<Notification> notifications = new ArrayList<>();
		String sql = "SELECT n.*, " + "b1.title as book_a_title, b2.title as book_b_title, "
				+ "u.username as other_username " + "FROM notifications n "
				+ "LEFT JOIN potential_matches pm ON n.related_id = pm.match_id "
				+ "LEFT JOIN books b1 ON pm.book_a_id = b1.book_id "
				+ "LEFT JOIN books b2 ON pm.book_b_id = b2.book_id "
				+ "LEFT JOIN users u ON (pm.user_a_id != ? AND pm.user_a_id = u.user_id) "
				+ "OR (pm.user_b_id != ? AND pm.user_b_id = u.user_id) " + "WHERE n.user_id = ? "
				+ "ORDER BY n.created_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, userId);
			ps.setInt(3, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Notification notif = new Notification();
				notif.setNotificationId(rs.getInt("notification_id"));
				notif.setUserId(rs.getInt("user_id"));
				notif.setType(rs.getString("type"));
				notif.setRelatedId(rs.getInt("related_id"));
				notif.setRead(rs.getBoolean("is_read"));
				notif.setCreatedAt(rs.getTimestamp("created_at"));

				// Build detailed content based on type
				String type = rs.getString("type");
				if ("MATCH_FOUND".equals(type)) {
					String bookATitle = rs.getString("book_a_title");
					String bookBTitle = rs.getString("book_b_title");
					String otherUser = rs.getString("other_username");
					notif.setContent("Match found with " + (otherUser != null ? otherUser : "someone") + "! You give: "
							+ (bookATitle != null ? bookATitle : "a book") + " | You get: "
							+ (bookBTitle != null ? bookBTitle : "a book"));
				} else {
					notif.setContent(rs.getString("content"));
				}
				notifications.add(notif);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return notifications;
	}

	public int getUnreadCount(int userId) {
		String sql = "SELECT COUNT(*) FROM notifications WHERE user_id = ? AND is_read = false";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public void markAllAsRead(int userId) {
		String sql = "UPDATE notifications SET is_read = true " + "WHERE user_id = ? AND is_read = false";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean saveNotification(Notification notification) {
		String sql = "INSERT INTO notifications(user_id, type, content, related_id) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, notification.getUserId());
			ps.setString(2, notification.getType());
			ps.setString(3, notification.getContent());
			ps.setInt(4, notification.getRelatedId());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private Notification mapNotification(ResultSet rs) throws SQLException {
		Notification n = new Notification();
		n.setNotificationId(rs.getInt("notification_id"));
		n.setUserId(rs.getInt("user_id"));
		n.setType(rs.getString("type"));
		n.setContent(rs.getString("content"));
		n.setRelatedId(rs.getInt("related_id"));
		n.setRead(rs.getBoolean("is_read"));
		n.setCreatedAt(rs.getTimestamp("created_at"));
		return n;
	}
}