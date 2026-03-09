package com.bookswapx.model;

import java.sql.Timestamp;

public class ExchangeRequest {
	
	private int requestId;
	private int matchId;
	private int requesterId;
	private String status;
	private Timestamp createdAt;
	private Timestamp respondedAt;
	private Timestamp completedAt;
	
	public ExchangeRequest() {
	}

	public ExchangeRequest(int requestId, int matchId, int requesterId, String status, Timestamp createdAt,
			Timestamp respondedAt, Timestamp completedAt) {
		this.requestId = requestId;
		this.matchId = matchId;
		this.requesterId = requesterId;
		this.status = status;
		this.createdAt = createdAt;
		this.respondedAt = respondedAt;
		this.completedAt = completedAt;
	}

	public int getRequestId() {
		return requestId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}

	public int getMatchId() {
		return matchId;
	}

	public void setMatchId(int matchId) {
		this.matchId = matchId;
	}

	public int getRequesterId() {
		return requesterId;
	}

	public void setRequesterId(int requesterId) {
		this.requesterId = requesterId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getRespondedAt() {
		return respondedAt;
	}

	public void setRespondedAt(Timestamp respondedAt) {
		this.respondedAt = respondedAt;
	}

	public Timestamp getCompletedAt() {
		return completedAt;
	}

	public void setCompletedAt(Timestamp completedAt) {
		this.completedAt = completedAt;
	}

}
