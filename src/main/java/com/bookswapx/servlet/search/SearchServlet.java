package com.bookswapx.servlet.search;

import com.bookswapx.dao.BookDAO;
import com.bookswapx.dao.CategoryDAO;
import com.bookswapx.dao.ListingDAO;
import com.bookswapx.model.Book;
import com.bookswapx.model.Category;
import com.bookswapx.model.Listing;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();
	private CategoryDAO categoryDAO = new CategoryDAO();
	private BookDAO bookDAO = new BookDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		int currentUserId = loggedInUser.getUserId();

		List<Listing> listings = listingDAO.getAllActiveListings();

		listings = listings.stream().filter(l -> l.getUserId() != currentUserId).collect(Collectors.toList());

		String type = request.getParameter("type");
		if (type != null && !type.isEmpty()) {
			listings = listings.stream().filter(l -> type.equals(l.getType())).collect(Collectors.toList());
		}

		String keyword = request.getParameter("keyword");
		if (keyword != null && !keyword.trim().isEmpty()) {
			String kw = keyword.trim().toLowerCase();
			listings = listings.stream()
					.filter(l -> (l.getBookTitle() != null && l.getBookTitle().toLowerCase().contains(kw))
							|| (l.getBookAuthor() != null && l.getBookAuthor().toLowerCase().contains(kw)))
					.collect(Collectors.toList());
		}

		String categoryParam = request.getParameter("category");
		if (categoryParam != null && !categoryParam.isEmpty()) {
			try {
				int categoryId = Integer.parseInt(categoryParam);
				List<Book> categoryBooks = bookDAO.getBooksByCategory(categoryId);
				List<Integer> categoryBookIds = categoryBooks.stream().map(Book::getBookId)
						.collect(Collectors.toList());
				listings = listings.stream().filter(l -> categoryBookIds.contains(l.getBookId()))
						.collect(Collectors.toList());
			} catch (NumberFormatException e) {
				// invalid category param — ignore filter
			}
		}

		String sortBy = request.getParameter("sortBy");
		if (sortBy != null) {
			switch (sortBy) {
			case "price_asc":
				listings = listings.stream().sorted(Comparator.comparingDouble(Listing::getPrice))
						.collect(Collectors.toList());
				break;
			case "price_desc":
				listings = listings.stream().sorted(Comparator.comparingDouble(Listing::getPrice).reversed())
						.collect(Collectors.toList());
				break;
			case "newest":
			default:
				listings = listings.stream().sorted(Comparator.comparing(Listing::getCreatedAt).reversed())
						.collect(Collectors.toList());
				break;
			}
		}

		request.setAttribute("listings", listings);
		request.setAttribute("categories", categoryDAO.getAllCategories());
		request.setAttribute("keyword", keyword != null ? keyword : "");

		request.getRequestDispatcher("/views/search/search.jsp").forward(request, response);
	}
}