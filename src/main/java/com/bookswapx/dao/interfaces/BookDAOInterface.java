package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Book;
import java.util.List;

public interface BookDAOInterface {
	int addBook(Book book);

	Book getBookById(int bookId);

	Book getBookByTitleAndAuthor(String title, String author);

	List<Book> searchBooks(String keyword);

	List<Book> getBooksByCategory(int categoryId);
}