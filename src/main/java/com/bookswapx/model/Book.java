package com.bookswapx.model;

public class Book {

	private int bookId;
	private String title;
	private String author;
	private int categoryId;
	private String bookCondition;
	private String isbn;
	private int publicationYear;
	private String edition;

	public Book() {
	}

	public Book(int bookId, String title, String author, int categoryId, String bookCondition, String isbn,
			int publicationYear, String edition) {
		this.bookId = bookId;
		this.title = title;
		this.author = author;
		this.categoryId = categoryId;
		this.bookCondition = bookCondition;
		this.isbn = isbn;
		this.publicationYear = publicationYear;
		this.edition = edition;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getBookCondition() {
		return bookCondition;
	}

	public void setBookCondition(String bookCondition) {
		this.bookCondition = bookCondition;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public int getPublicationYear() {
		return publicationYear;
	}

	public void setPublicationYear(int publicationYear) {
		this.publicationYear = publicationYear;
	}

	public String getEdition() {
		return edition;
	}

	public void setEdition(String edition) {
		this.edition = edition;
	}

}
