package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.BookDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO implements BookDAOInterface {

	public int addBook(Book book) {
		String sql = "Insert into books (title, author, category_id, book_condition, isbn, publication_year, edition) values (?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			ps.setInt(3, book.getCategoryId());
			ps.setString(4, book.getBookCondition());
			ps.setString(5, book.getIsbn());
			if (book.getPublicationYear() > 0) {
				ps.setInt(6, book.getPublicationYear());
			} else {
				ps.setNull(6, java.sql.Types.INTEGER);
			}
			ps.setString(7, book.getEdition());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public Book getBookById(int bookId) {
		String sql = "Select * from books where book_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, bookId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return mapBook(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Book> searchBooks(String keyword) {
		List<Book> books = new ArrayList<>();
		String sql = "Select * from books where title like ? or author like ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, "%" + keyword + "%");
			ps.setString(2, "%" + keyword + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				books.add(mapBook(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return books;
	}

	public List<Book> getBooksByCategory(int categoryId) {
		List<Book> books = new ArrayList<>();
		String sql = "Select * from books where category_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, categoryId);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				books.add(mapBook(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return books;
	}

	public Book getBookByTitleAndAuthor(String title, String author) {
		String sql = "SELECT * FROM books WHERE LOWER(TRIM(title)) = LOWER(TRIM(?))";
		if (author != null && !author.isEmpty()) {
			sql += " AND LOWER(TRIM(author)) = LOWER(TRIM(?))";
		}
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, title);
			if (author != null && !author.isEmpty()) {
				ps.setString(2, author);
			}
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getInt("book_id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setCategoryId(rs.getInt("category_id"));
				book.setBookCondition(rs.getString("book_condition"));
				book.setIsbn(rs.getString("isbn"));
				book.setEdition(rs.getString("edition"));
				return book;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private Book mapBook(ResultSet rs) throws SQLException {
		Book book = new Book();
		book.setBookId(rs.getInt("book_id"));
		book.setTitle(rs.getString("title"));
		book.setAuthor(rs.getString("author"));
		book.setCategoryId(rs.getInt("category_id"));
		book.setBookCondition(rs.getString("book_condition"));
		book.setIsbn(rs.getString("isbn"));
		book.setPublicationYear(rs.getInt("publication_year"));
		book.setEdition(rs.getString("edition"));
		return book;
	}

}
