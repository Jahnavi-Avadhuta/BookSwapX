package com.bookswapx.model;

import java.sql.Timestamp;

public class Transaction {

	private int transactionId;
	private int listingId;
	private int buyerId;
	private int sellerId;
	private int bookId;
	private String transactionType;
	private double price;
	private boolean isExchange;
	private Timestamp completedAt;
	private String bookTitle;
	private String bookAuthor;
	private String buyerName;
	private String sellerName;

	public Transaction() {
	}

	public Transaction(int transactionId, int listingId, int buyerId, int sellerId, int bookId, String transactionType,
			double price, boolean isExchange, Timestamp completedAt, String bookTitle, String bookAuthor,
			String buyerName, String sellerName) {
		this.transactionId = transactionId;
		this.listingId = listingId;
		this.buyerId = buyerId;
		this.sellerId = sellerId;
		this.bookId = bookId;
		this.transactionType = transactionType;
		this.price = price;
		this.isExchange = isExchange;
		this.completedAt = completedAt;
		this.bookTitle = bookTitle;
		this.bookAuthor = bookAuthor;
		this.buyerName = buyerName;
		this.sellerName = sellerName;
	}

	public int getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
	}

	public int getListingId() {
		return listingId;
	}

	public void setListingId(int listingId) {
		this.listingId = listingId;
	}

	public int getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(int buyerId) {
		this.buyerId = buyerId;
	}

	public int getSellerId() {
		return sellerId;
	}

	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public boolean isExchange() {
		return isExchange;
	}

	public void setExchange(boolean isExchange) {
		this.isExchange = isExchange;
	}

	public Timestamp getCompletedAt() {
		return completedAt;
	}

	public void setCompletedAt(Timestamp completedAt) {
		this.completedAt = completedAt;
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

	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

}
