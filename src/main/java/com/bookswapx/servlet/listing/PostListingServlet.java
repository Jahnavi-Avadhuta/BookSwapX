package com.bookswapx.servlet.listing;

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
import java.util.List;

@WebServlet("/listing/post")
public class PostListingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private BookDAO bookDAO = new BookDAO();
	private ListingDAO listingDAO = new ListingDAO();
	private CategoryDAO categoryDAO = new CategoryDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		if ("ADMIN".equals(loggedInUser.getRole())) {
			response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=admincannotpost");
			return;
		}

		List<Category> categories = categoryDAO.getAllCategories();
		request.setAttribute("categories", categories);
		request.getRequestDispatcher("/views/listing/post-listing.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		if ("ADMIN".equals(loggedInUser.getRole())) {
			response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=admincannotpost");
			return;
		}

		String title = request.getParameter("title") != null ? request.getParameter("title").trim() : "";
		String type = request.getParameter("type") != null ? request.getParameter("type").trim() : "";
		String bookCondition = request.getParameter("bookCondition") != null
				? request.getParameter("bookCondition").trim()
				: "";

		if (title.isEmpty() || type.isEmpty() || bookCondition.isEmpty()) {
			request.setAttribute("error", "Title, type and condition are required.");
			request.setAttribute("categories", categoryDAO.getAllCategories());
			request.getRequestDispatcher("/views/listing/post-listing.jsp").forward(request, response);
			return;
		}

		String categoryParam = request.getParameter("categoryId");
		if (categoryParam == null || categoryParam.isEmpty()) {
			request.setAttribute("error", "Please select a category.");
			request.setAttribute("categories", categoryDAO.getAllCategories());
			request.getRequestDispatcher("/views/listing/post-listing.jsp").forward(request, response);
			return;
		}
		int categoryId = Integer.parseInt(categoryParam);

		String author = request.getParameter("author") != null ? request.getParameter("author").trim() : "";
		String isbn = request.getParameter("isbn") != null ? request.getParameter("isbn").trim() : "";
		String edition = request.getParameter("edition") != null ? request.getParameter("edition").trim() : "";
		String description = request.getParameter("description") != null ? request.getParameter("description").trim()
				: "";
		String meetingLocation = request.getParameter("meetingLocation") != null
				? request.getParameter("meetingLocation").trim()
				: "";
		String priceParam = request.getParameter("price");
		double price = (priceParam != null && !priceParam.isEmpty()) ? Double.parseDouble(priceParam) : 0.00;
		if ("BUY".equals(type))
			price = 0.00;

		Book existingBook = bookDAO.getBookByTitleAndAuthor(title, author);
		int bookId;

		if (existingBook != null) {
			bookId = existingBook.getBookId();
		} else {
			Book book = new Book();
			book.setTitle(title);
			book.setAuthor(author);
			book.setCategoryId(categoryId);
			book.setBookCondition(bookCondition);
			book.setIsbn(isbn);
			book.setEdition(edition);
			bookId = bookDAO.addBook(book);
		}

		Listing listing = new Listing();
		listing.setUserId(loggedInUser.getUserId());
		listing.setBookId(bookId);
		listing.setType(type);
		listing.setPrice(price);
		listing.setDescription(description);
		listing.setMeetingLocation(meetingLocation);

		listingDAO.addListing(listing);

		response.sendRedirect(request.getContextPath() + "/user/mybooks?success=posted");
	}
}