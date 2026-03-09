package com.bookswapx.model;

import java.sql.Timestamp;

public class PotentialMatch {

	private int matchId;
	private int userAId;
	private int userBId;
	private int bookAId;
	private int bookBId;
	private Timestamp matchDate;
	private String status;
	private String bookATitle;
	private String bookAAuthor;
	private String bookBTitle;
	private String bookBAuthor;
	private String userAName;
	private String userBName;

	public PotentialMatch() {
	}

	public PotentialMatch(int matchId, int userAId, int userBId, int bookAId, int bookBId, Timestamp matchDate,
			String status, String bookATitle, String bookAAuthor, String bookBTitle, String bookBAuthor,
			String userAName, String userBName) {
		this.matchId = matchId;
		this.userAId = userAId;
		this.userBId = userBId;
		this.bookAId = bookAId;
		this.bookBId = bookBId;
		this.matchDate = matchDate;
		this.status = status;
		this.bookATitle = bookATitle;
		this.bookAAuthor = bookAAuthor;
		this.bookBTitle = bookBTitle;
		this.bookBAuthor = bookBAuthor;
		this.userAName = userAName;
		this.userBName = userBName;
	}

	public int getMatchId() {
		return matchId;
	}

	public void setMatchId(int matchId) {
		this.matchId = matchId;
	}

	public int getUserAId() {
		return userAId;
	}

	public void setUserAId(int userAId) {
		this.userAId = userAId;
	}

	public int getUserBId() {
		return userBId;
	}

	public void setUserBId(int userBId) {
		this.userBId = userBId;
	}

	public int getBookAId() {
		return bookAId;
	}

	public void setBookAId(int bookAId) {
		this.bookAId = bookAId;
	}

	public int getBookBId() {
		return bookBId;
	}

	public void setBookBId(int bookBId) {
		this.bookBId = bookBId;
	}

	public Timestamp getMatchDate() {
		return matchDate;
	}

	public void setMatchDate(Timestamp matchDate) {
		this.matchDate = matchDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBookATitle() {
		return bookATitle;
	}

	public void setBookATitle(String bookATitle) {
		this.bookATitle = bookATitle;
	}

	public String getBookAAuthor() {
		return bookAAuthor;
	}

	public void setBookAAuthor(String bookAAuthor) {
		this.bookAAuthor = bookAAuthor;
	}

	public String getBookBTitle() {
		return bookBTitle;
	}

	public void setBookBTitle(String bookBTitle) {
		this.bookBTitle = bookBTitle;
	}

	public String getBookBAuthor() {
		return bookBAuthor;
	}

	public void setBookBAuthor(String bookBAuthor) {
		this.bookBAuthor = bookBAuthor;
	}

	public String getUserAName() {
		return userAName;
	}

	public void setUserAName(String userAName) {
		this.userAName = userAName;
	}

	public String getUserBName() {
		return userBName;
	}

	public void setUserBName(String userBName) {
		this.userBName = userBName;
	}

}
