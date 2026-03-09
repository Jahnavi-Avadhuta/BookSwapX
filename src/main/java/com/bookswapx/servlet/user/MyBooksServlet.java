package com.bookswapx.servlet.user;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import com.bookswapx.dao.ListingDAO;
import com.bookswapx.dao.WishlistDAO;
import com.bookswapx.model.Listing;
import com.bookswapx.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/mybooks")
public class MyBooksServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ListingDAO listingDAO = new ListingDAO();
	private WishlistDAO wishlistDAO = new WishlistDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		int userId = loggedInUser.getUserId();

		List<Listing> allListings = listingDAO.getListingsByUser(userId);

		List<Listing> sellListings = allListings.stream()
				.filter(l -> "SELL".equals(l.getType()) && "AVAILABLE".equals(l.getStatus()))
				.collect(Collectors.toList());

		List<Listing> buyListings = allListings.stream()
				.filter(l -> "BUY".equals(l.getType()) && "AVAILABLE".equals(l.getStatus()))
				.collect(Collectors.toList());

		List<Listing> completedListings = allListings.stream()
				.filter(l -> "EXCHANGED".equals(l.getStatus()) || "SOLD".equals(l.getStatus()))
				.collect(Collectors.toList());

		request.setAttribute("sellListings", sellListings);
		request.setAttribute("buyListings", buyListings);
		request.setAttribute("completedListings", completedListings);

		request.getRequestDispatcher("/views/user/mybooks.jsp").forward(request, response);
	}
}