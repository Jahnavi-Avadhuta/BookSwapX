package com.bookswapx.servlet.listing;

import com.bookswapx.dao.ListingDAO;
import com.bookswapx.dao.NotificationDAO;
import com.bookswapx.dao.TransactionDAO;
import com.bookswapx.model.Listing;
import com.bookswapx.model.Notification;
import com.bookswapx.model.Transaction;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/listing/buy")
public class BuyListingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();
	private TransactionDAO transactionDAO = new TransactionDAO();
	private NotificationDAO notificationDAO = new NotificationDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User buyer = (User) session.getAttribute("loggedInUser");

		String listingIdParam = request.getParameter("listingId");
		if (listingIdParam == null || listingIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/search");
			return;
		}

		int listingId = Integer.parseInt(listingIdParam);
		Listing listing = listingDAO.getListingById(listingId);

		if (listing == null || listing.isDeleted() || !"AVAILABLE".equals(listing.getStatus())) {
			response.sendRedirect(request.getContextPath() + "/search?error=notavailable");
			return;
		}

		if (listing.getUserId() == buyer.getUserId()) {
			response.sendRedirect(request.getContextPath() + "/search?error=ownlisting");
			return;
		}

		Transaction transaction = new Transaction();
		transaction.setListingId(listingId);
		transaction.setBuyerId(buyer.getUserId());
		transaction.setSellerId(listing.getUserId());
		transaction.setBookId(listing.getBookId());
		transaction.setTransactionType("SALE");
		transaction.setPrice(listing.getPrice());
		transaction.setExchange(false);
		transactionDAO.addTransaction(transaction);

		listingDAO.updateListingStatus(listingId, "SOLD");

		Notification notification = new Notification();
		notification.setUserId(listing.getUserId());
		notification.setType("REQUEST_ACCEPTED");
		notification.setContent("Your book has been purchased by " + buyer.getUsername() + "!");
		notification.setRelatedId(listingId);
		notificationDAO.saveNotification(notification);

		response.sendRedirect(request.getContextPath() + "/user/transactions?success=purchased");
	}
}