package com.bookswapx.servlet.user;

import com.bookswapx.dao.*;
import com.bookswapx.model.Listing;
import com.bookswapx.model.Transaction;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/user/dashboard")
public class DashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();
	private NotificationDAO notificationDAO = new NotificationDAO();
	private MessageDAO messageDAO = new MessageDAO();
	private TransactionDAO transactionDAO = new TransactionDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		int userId = loggedInUser.getUserId();

		List<Listing> allListings = listingDAO.getListingsByUser(userId);
		List<Listing> activeListings = allListings.stream().filter(l -> "AVAILABLE".equals(l.getStatus()))
				.collect(Collectors.toList());

		List<Transaction> recentTransactions = transactionDAO.getTransactionsByUser(userId);

		int unreadMessages = messageDAO.getUnreadCount(userId);
		int unreadNotifications = notificationDAO.getUnreadCount(userId);

		request.setAttribute("myListings", activeListings);
		request.setAttribute("recentTransactions", recentTransactions);
		request.setAttribute("unreadMessages", unreadMessages);
		request.setAttribute("unreadNotifications", unreadNotifications);

		session.setAttribute("unreadMessages", unreadMessages);
		session.setAttribute("unreadNotifications", unreadNotifications);

		request.getRequestDispatcher("/views/user/dashboard.jsp").forward(request, response);
	}
}