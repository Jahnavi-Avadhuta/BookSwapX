package com.bookswapx.model;

import java.sql.Timestamp;

public class User {

	private int userId;
	private String username;
	private String email;
	private String password;
	private String location;
	private String role;
	private String profilePicture;
	private double trustScore;
	private boolean isActive;
	private Timestamp createdAt;
	private Timestamp lastLogin;

	public User() {
	}

	public User(int userId, String username, String email, String password, String location, String role,
			String profilePicture, double trustScore, boolean isActive, Timestamp createdAt, Timestamp lastLogin) {
		this.userId = userId;
		this.username = username;
		this.email = email;
		this.password = password;
		this.location = location;
		this.role = role;
		this.profilePicture = profilePicture;
		this.trustScore = trustScore;
		this.isActive = isActive;
		this.createdAt = createdAt;
		this.lastLogin = lastLogin;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getProfilePicture() {
		return profilePicture;
	}

	public void setProfilePicture(String profilePicture) {
		this.profilePicture = profilePicture;
	}

	public double getTrustScore() {
		return trustScore;
	}

	public void setTrustScore(double trustScore) {
		this.trustScore = trustScore;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Timestamp lastLogin) {
		this.lastLogin = lastLogin;
	}

}
