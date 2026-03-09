package com.bookswapx.servlet.listing;

import com.bookswapx.dao.BookDAO;
import com.bookswapx.dao.ListingDAO;
import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.Listing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/listing/detail")
public class ListingDetailServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();
	private BookDAO bookDAO = new BookDAO();
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idParam = request.getParameter("id");
		if (idParam == null) {
			response.sendRedirect(request.getContextPath() + "/search");
			return;
		}

		int listingId = Integer.parseInt(idParam);
		Listing listing = listingDAO.getListingById(listingId);

		if (listing == null) {
			response.sendRedirect(request.getContextPath() + "/search");
			return;
		}

		request.setAttribute("listing", listing);
		request.setAttribute("book", bookDAO.getBookById(listing.getBookId()));
		request.setAttribute("owner", userDAO.getUserById(listing.getUserId()));

		request.getRequestDispatcher("/views/listing/listing-detail.jsp").forward(request, response);
	}
}