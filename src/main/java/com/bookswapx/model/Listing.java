package com.bookswapx.model;

import java.sql.Timestamp;

public class Listing {

	private int listingId;
	private int userId;
	private int bookId;
	private String type;
	private double price;
	private String status;
	private boolean isDeleted;
	private Timestamp deletedAt;
	private String description;
	private String meetingLocation;
	private Timestamp createdAt;
	private String bookTitle;
	private String bookAuthor;
	private String bookCondition;
	private String bookEdition;
	private String bookIsbn;
	private String ownerName;

	public Listing() {
	}

	public Listing(int listingId, int userId, int bookId, String type, double price, String status, boolean isDeleted,
			Timestamp deletedAt, String description, String meetingLocation, Timestamp createdAt, String bookTitle,
			String bookAuthor, String bookCondition, String bookEdition, String bookIsbn, String ownerName) {
		this.listingId = listingId;
		this.userId = userId;
		this.bookId = bookId;
		this.type = type;
		this.price = price;
		this.status = status;
		this.isDeleted = isDeleted;
		this.deletedAt = deletedAt;
		this.description = description;
		this.meetingLocation = meetingLocation;
		this.createdAt = createdAt;
		this.bookTitle = bookTitle;
		this.bookAuthor = bookAuthor;
		this.bookCondition = bookCondition;
		this.bookEdition = bookEdition;
		this.bookIsbn = bookIsbn;
		this.ownerName = ownerName;
	}

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	public String getBookAuthor() {
		return bookAuthor;
	}

	public void setBookAuthor(String bookAuthor) {
		this.bookAuthor = bookAuthor;
	}

	public String getBookCondition() {
		return bookCondition;
	}

	public void setBookCondition(String bookCondition) {
		this.bookCondition = bookCondition;
	}

	public String getBookEdition() {
		return bookEdition;
	}

	public void setBookEdition(String bookEdition) {
		this.bookEdition = bookEdition;
	}

	public String getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public int getListingId() {
		return listingId;
	}

	public void setListingId(int listingId) {
		this.listingId = listingId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public Timestamp getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(Timestamp deletedAt) {
		this.deletedAt = deletedAt;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMeetingLocation() {
		return meetingLocation;
	}

	public void setMeetingLocation(String meetingLocation) {
		this.meetingLocation = meetingLocation;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getOwnerName() {
		return ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

}
