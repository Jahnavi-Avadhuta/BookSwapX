package com.bookswapx.servlet.listing;

import com.bookswapx.dao.ListingDAO;
import com.bookswapx.model.Listing;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/listing/edit")
public class EditListingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int listingId = Integer.parseInt(request.getParameter("id"));
		Listing listing = listingDAO.getListingById(listingId);

		if (listing == null) {
			response.sendRedirect(request.getContextPath() + "/user/mybooks");
			return;
		}

		request.setAttribute("listing", listing);
		request.getRequestDispatcher("/views/listing/post-listing.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		int listingId = Integer.parseInt(request.getParameter("listingId"));
		String status = request.getParameter("status");

		Listing listing = listingDAO.getListingById(listingId);
		if (listing == null || listing.getUserId() != loggedInUser.getUserId()) {
			response.sendRedirect(request.getContextPath() + "/user/mybooks");
			return;
		}

		boolean success = listingDAO.updateListingStatus(listingId, status);

		if (success) {
			response.sendRedirect(request.getContextPath() + "/user/mybooks?success=updated");
		} else {
			response.sendRedirect(request.getContextPath() + "/user/mybooks?error=updatefailed");
		}
	}
}