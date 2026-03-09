package com.bookswapx.model;

import java.sql.Timestamp;

public class Review {

	private int reviewId;
	private int reviewerId;
	private int reviewedUserId;
	private int rating;
	private String comment;
	private Timestamp createdAt;

	public Review() {
	}
	
	public Review(int reviewId, int reviewerId, int reviewedUserId, int rating, String comment, Timestamp createdAt) {
		this.reviewId = reviewId;
		this.reviewerId = reviewerId;
		this.reviewedUserId = reviewedUserId;
		this.rating = rating;
		this.comment = comment;
		this.createdAt = createdAt;
	}

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public int getReviewerId() {
		return reviewerId;
	}

	public void setReviewerId(int reviewerId) {
		this.reviewerId = reviewerId;
	}

	public int getReviewedUserId() {
		return reviewedUserId;
	}

	public void setReviewedUserId(int reviewedUserId) {
		this.reviewedUserId = reviewedUserId;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

}
