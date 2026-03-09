package com.bookswapx.servlet.listing;

import com.bookswapx.dao.ListingDAO;
import com.bookswapx.model.Listing;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/listing/delete")
public class DeleteListingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		int listingId = Integer.parseInt(request.getParameter("listingId"));

		Listing listing = listingDAO.getListingById(listingId);
		if (listing == null || listing.getUserId() != loggedInUser.getUserId()) {
			response.sendRedirect(request.getContextPath() + "/user/mybooks?error=unauthorized");
			return;
		}

		boolean success = listingDAO.softDeleteListing(listingId);

		if (success) {
			response.sendRedirect(request.getContextPath() + "/user/mybooks?success=deleted");
		} else {
			response.sendRedirect(request.getContextPath() + "/user/mybooks?error=deletefailed");
		}
	}
}