package com.bookswapx.servlet.exchange;

import com.bookswapx.dao.ExchangeDAO;
import com.bookswapx.dao.ListingDAO;
import com.bookswapx.dao.MatchDAO;
import com.bookswapx.dao.NotificationDAO;
import com.bookswapx.dao.TransactionDAO;
import com.bookswapx.model.ExchangeRequest;
import com.bookswapx.model.Notification;
import com.bookswapx.model.PotentialMatch;
import com.bookswapx.model.Transaction;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/exchange/request")
public class ExchangeRequestServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ExchangeDAO exchangeDAO = new ExchangeDAO();
	private MatchDAO matchDAO = new MatchDAO();
	private ListingDAO listingDAO = new ListingDAO();
	private TransactionDAO transactionDAO = new TransactionDAO();
	private NotificationDAO notificationDAO = new NotificationDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String action = request.getParameter("action");
		int matchId = Integer.parseInt(request.getParameter("matchId"));

		PotentialMatch match = matchDAO.getMatchById(matchId);

		if (match == null) {
			response.sendRedirect(request.getContextPath() + "/exchange/matches?error=notfound");
			return;
		}

		int otherUserId = match.getUserAId() == loggedInUser.getUserId() ? match.getUserBId() : match.getUserAId();

		if ("REQUEST".equals(action)) {
			ExchangeRequest er = new ExchangeRequest();
			er.setMatchId(matchId);
			er.setRequesterId(loggedInUser.getUserId());
			exchangeDAO.createRequest(er);

			int listingAId = matchDAO.getListingIdByBookAndUser(match.getBookAId(), match.getUserAId());
			int listingBId = matchDAO.getListingIdByBookAndUser(match.getBookBId(), match.getUserBId());
			listingDAO.updateListingStatus(listingAId, "PENDING");
			listingDAO.updateListingStatus(listingBId, "PENDING");

			matchDAO.updateMatchStatus(matchId, "ACCEPTED");

			Notification notification = new Notification();
			notification.setUserId(otherUserId);
			notification.setType("REQUEST_RECEIVED");
			notification.setContent(loggedInUser.getUsername() + " wants to exchange books with you!");
			notification.setRelatedId(matchId);
			notificationDAO.saveNotification(notification);

			response.sendRedirect(request.getContextPath() + "/exchange/matches?success=requested");

		} else if ("ACCEPT".equals(action)) {

			ExchangeRequest er = exchangeDAO.getRequestByMatchId(matchId);
			if (er != null) {
				exchangeDAO.updateRequestStatus(er.getRequestId(), "ACCEPTED");
			}

			int listingAId = matchDAO.getListingIdByBookAndUser(match.getBookAId(), match.getUserAId());
			int listingBId = matchDAO.getListingIdByBookAndUser(match.getBookBId(), match.getUserBId());

			listingDAO.updateListingStatus(listingAId, "EXCHANGED");
			listingDAO.updateListingStatus(listingBId, "EXCHANGED");

			Transaction transaction = new Transaction();
			transaction.setListingId(listingAId);
			transaction.setBuyerId(match.getUserBId());
			transaction.setSellerId(match.getUserAId());
			transaction.setBookId(match.getBookAId());
			transaction.setTransactionType("EXCHANGE");
			transaction.setPrice(0.00);
			transaction.setExchange(true);
			transactionDAO.addTransaction(transaction);

			matchDAO.updateMatchStatus(matchId, "COMPLETED");

			Notification notification = new Notification();
			notification.setUserId(otherUserId);
			notification.setType("REQUEST_ACCEPTED");
			notification.setContent(
					loggedInUser.getUsername() + " accepted your exchange! Arrange meetup to exchange books.");
			notification.setRelatedId(matchId);
			notificationDAO.saveNotification(notification);

			response.sendRedirect(request.getContextPath() + "/exchange/matches?success=accepted");

		} else if ("REJECT".equals(action)) {

			ExchangeRequest er = exchangeDAO.getRequestByMatchId(matchId);
			if (er != null) {
				exchangeDAO.updateRequestStatus(er.getRequestId(), "REJECTED");
			}

			int listingAId = matchDAO.getListingIdByBookAndUser(match.getBookAId(), match.getUserAId());
			int listingBId = matchDAO.getListingIdByBookAndUser(match.getBookBId(), match.getUserBId());
			listingDAO.updateListingStatus(listingAId, "AVAILABLE");
			listingDAO.updateListingStatus(listingBId, "AVAILABLE");

			matchDAO.updateMatchStatus(matchId, "PENDING");

			Notification notification = new Notification();
			notification.setUserId(otherUserId);
			notification.setType("REQUEST_RECEIVED");
			notification
					.setContent(loggedInUser.getUsername() + " rejected your exchange request. You can send again.");
			notification.setRelatedId(matchId);
			notificationDAO.saveNotification(notification);

			response.sendRedirect(request.getContextPath() + "/exchange/matches?success=rejected");
		}
	}
}