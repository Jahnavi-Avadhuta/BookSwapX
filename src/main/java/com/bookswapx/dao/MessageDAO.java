package com.bookswapx.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookswapx.dao.interfaces.MessageDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Message;
import com.bookswapx.model.User;

public class MessageDAO implements MessageDAOInterface {

	public boolean sendMessage(Message message) {
		String sql = "INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, message.getSenderId());
			ps.setInt(2, message.getReceiverId());
			ps.setString(3, message.getMessage());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private Message mapMessage(ResultSet rs) throws SQLException {
		Message msg = new Message();
		msg.setMessageId(rs.getInt("message_id"));
		msg.setSenderId(rs.getInt("sender_id"));
		msg.setReceiverId(rs.getInt("receiver_id"));
		msg.setMessage(rs.getString("message"));
		msg.setSentAt(rs.getTimestamp("sent_at"));
		msg.setRead(rs.getBoolean("is_read"));
		msg.setDeletedBySender(rs.getBoolean("is_deleted_by_sender"));
		msg.setDeletedByReceiver(rs.getBoolean("is_deleted_by_receiver"));
		return msg;
	}

	public List<Message> getConversation(int userAId, int userBId) {
		List<Message> messages = new ArrayList<>();
		String sql = "SELECT * FROM messages WHERE " + "((sender_id = ? AND receiver_id = ? "
				+ "AND is_deleted_by_sender = false) " + "OR (sender_id = ? AND receiver_id = ? "
				+ "AND is_deleted_by_receiver = false)) " + "ORDER BY sent_at ASC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userAId);
			ps.setInt(2, userBId);
			ps.setInt(3, userBId);
			ps.setInt(4, userAId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				messages.add(mapMessage(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return messages;
	}

	public void markAsRead(int senderId, int receiverId) {
		String sql = "UPDATE messages SET is_read = true WHERE sender_id = ? AND receiver_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, senderId);
			ps.setInt(2, receiverId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int getUnreadCount(int userId) {
		String sql = "SELECT COUNT(*) FROM messages WHERE receiver_id = ? AND is_read = false";
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

	public List<Integer> getConversationUsers(int userId) {
		List<Integer> userIds = new ArrayList<>();
		String sql = "SELECT DISTINCT other_user_id FROM (" + "SELECT receiver_id as other_user_id FROM messages "
				+ "WHERE sender_id = ? AND is_deleted_by_sender = false " + "UNION "
				+ "SELECT sender_id as other_user_id FROM messages "
				+ "WHERE receiver_id = ? AND is_deleted_by_receiver = false" + ") AS conversation_users "
				+ "ORDER BY other_user_id";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				userIds.add(rs.getInt("other_user_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userIds;
	}

	public List<User> getAllConversations(int userId) {
		// Returns list of users this person has chatted with
		String sql = "SELECT DISTINCT u.* FROM users u " + "JOIN messages m ON "
				+ "(m.sender_id = u.user_id AND m.receiver_id = ?) OR "
				+ "(m.receiver_id = u.user_id AND m.sender_id = ?) " + "WHERE u.user_id != ? " + "ORDER BY u.username";

		List<User> users = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, userId);
			ps.setInt(3, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					users.add(mapUser(rs));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	private User mapUser(ResultSet rs) throws SQLException {
		User user = new User();
		user.setUserId(rs.getInt("user_id"));
		user.setUsername(rs.getString("username"));
		user.setEmail(rs.getString("email"));
		user.setLocation(rs.getString("location"));
		user.setRole(rs.getString("role"));
		user.setTrustScore(rs.getDouble("trust_score"));
		user.setActive(rs.getBoolean("is_active"));
		user.setProfilePicture(rs.getString("profile_picture"));
		return user;
	}
}