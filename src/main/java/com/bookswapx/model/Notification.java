package com.bookswapx.model;

import java.sql.Timestamp;

public class Notification {

	private int notificationId;
	private int userId;
	private String type;
	private String content;
	private int relatedId;
	private boolean isRead;
	private Timestamp createdAt;

	public Notification() {
	}

	public Notification(int notificationId, int userId, String type, String content, int relatedId, boolean isRead,
			Timestamp createdAt) {
		this.notificationId = notificationId;
		this.userId = userId;
		this.type = type;
		this.content = content;
		this.relatedId = relatedId;
		this.isRead = isRead;
		this.createdAt = createdAt;
	}

	public int getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getRelatedId() {
		return relatedId;
	}

	public void setRelatedId(int relatedId) {
		this.relatedId = relatedId;
	}

	public boolean isRead() {
		return isRead;
	}

	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

}
