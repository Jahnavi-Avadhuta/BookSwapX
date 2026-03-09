package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.UserDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements UserDAOInterface {

	public boolean registerUser(User user) {
		String sql = "Insert into users(username, email, password, location) values(?,?,?,?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getLocation());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public User getUserByEmail(String email) {
		String sql = "Select * from users where email =?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return mapUser(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public User getUserById(int userId) {
		String sql = "Select * from users where user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return mapUser(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateProfile(int userId, String location, String profilePicture) {
		String sql = "UPDATE users SET location = ?, profile_picture = ? WHERE user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, location);
			ps.setString(2, profilePicture);
			ps.setInt(3, userId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public void updateLastLogin(int userId) {
		String sql = "Update users set last_login = current_timestamp where user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean updateTrustScore(int userId, double score) {
		String sql = "Update users set trust_score = ? where user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDouble(1, score);
			ps.setInt(2, userId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean setUserActiveStatus(int userId, boolean isActive) {
		String sql = "Update users set is_sctive = ? where user_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setBoolean(1, isActive);
			ps.setInt(2, userId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		String sql = "Select * from users order by created_at desc";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				users.add(mapUser(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	public boolean emailExists(String email) {
		String sql = "Select 1 from users where email=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private User mapUser(ResultSet rs) throws SQLException {
		User user = new User();
		user.setUserId(rs.getInt("user_id"));
		user.setUsername(rs.getString("username"));
		user.setEmail(rs.getString("email"));
		user.setPassword(rs.getString("password"));
		user.setLocation(rs.getString("location"));
		user.setRole(rs.getString("role"));
		user.setProfilePicture(rs.getString("profile_picture"));
		user.setTrustScore(rs.getDouble("trust_score"));
		user.setActive(rs.getBoolean("is_active"));
		user.setCreatedAt(rs.getTimestamp("created_at"));
		user.setLastLogin(rs.getTimestamp("last_login"));
		return user;
	}
}
