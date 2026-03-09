package com.bookswapx.model;

import java.sql.Timestamp;

public class Report {

	private int reportId;
	private int reporterId;
	private Integer reportedUserId;
	private Integer reportedListingId;
	private String reason;
	private String description;
	private String status;
	private Timestamp createdAt;

	public Report() {
	}

	public Report(int reportId, int reporterId, Integer reportedUserId, Integer reportedListingId, String reason,
			String description, String status, Timestamp createdAt) {
		this.reportId = reportId;
		this.reporterId = reporterId;
		this.reportedUserId = reportedUserId;
		this.reportedListingId = reportedListingId;
		this.reason = reason;
		this.description = description;
		this.status = status;
		this.createdAt = createdAt;
	}

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public int getReporterId() {
		return reporterId;
	}

	public void setReporterId(int reporterId) {
		this.reporterId = reporterId;
	}

	public Integer getReportedUserId() {
		return reportedUserId;
	}

	public void setReportedUserId(int reportedUserId) {
		this.reportedUserId = reportedUserId;
	}

	public Integer getReportedListingId() {
		return reportedListingId;
	}

	public void setReportedListingId(int reportedListingId) {
		this.reportedListingId = reportedListingId;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

}
