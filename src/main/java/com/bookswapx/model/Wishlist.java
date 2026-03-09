package com.bookswapx.model;

import java.sql.Timestamp;

public class Wishlist {

	private int wishlistId;
	private int userId;
	private int bookId;
	private Timestamp createdAt;
	private String bookTitle;
	private String bookAuthor;
	private String bookCondition;
	private String bookEdition;
	private String bookIsbn;

	public Wishlist() {
	}

	public Wishlist(int wishlistId, int userId, int bookId, Timestamp createdAt, String bookTitle, String bookAuthor,
			String bookCondition, String bookEdition, String bookIsbn) {
		this.wishlistId = wishlistId;
		this.userId = userId;
		this.bookId = bookId;
		this.createdAt = createdAt;
		this.bookTitle = bookTitle;
		this.bookAuthor = bookAuthor;
		this.bookCondition = bookCondition;
		this.bookEdition = bookEdition;
		this.bookIsbn = bookIsbn;
	}

	public int getWishlistId() {
		return wishlistId;
	}

	public void setWishlistId(int wishlistId) {
		this.wishlistId = wishlistId;
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

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
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

}
