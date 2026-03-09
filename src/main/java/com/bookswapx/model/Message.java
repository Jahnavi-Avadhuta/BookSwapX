package com.bookswapx.model;

import java.sql.Timestamp;

public class Message {

	private int messageId;
	private int senderId;
	private int receiverId;
	private String message;
	private Timestamp sentAt;
	private boolean isRead;
	private boolean isDeletedBySender;
	private boolean isDeletedByReceiver;

	public Message() {
	}

	public Message(int messageId, int senderId, int receiverId, String message, Timestamp sentAt, boolean isRead,
			boolean isDeletedBySender, boolean isDeletedByReceiver) {
		this.messageId = messageId;
		this.senderId = senderId;
		this.receiverId = receiverId;
		this.message = message;
		this.sentAt = sentAt;
		this.isRead = isRead;
		this.isDeletedBySender = isDeletedBySender;
		this.isDeletedByReceiver = isDeletedByReceiver;
	}

	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}

	public int getSenderId() {
		return senderId;
	}

	public void setSenderId(int senderId) {
		this.senderId = senderId;
	}

	public int getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(int receiverId) {
		this.receiverId = receiverId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getSentAt() {
		return sentAt;
	}

	public void setSentAt(Timestamp sentAt) {
		this.sentAt = sentAt;
	}

	public boolean isRead() {
		return isRead;
	}

	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}

	public boolean isDeletedBySender() {
		return isDeletedBySender;
	}

	public void setDeletedBySender(boolean isDeletedBySender) {
		this.isDeletedBySender = isDeletedBySender;
	}

	public boolean isDeletedByReceiver() {
		return isDeletedByReceiver;
	}

	public void setDeletedByReceiver(boolean isDeletedByReceiver) {
		this.isDeletedByReceiver = isDeletedByReceiver;
	}

}
