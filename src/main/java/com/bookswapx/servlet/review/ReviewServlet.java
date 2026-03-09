package com.bookswapx.servlet.review;

import com.bookswapx.dao.NotificationDAO;
import com.bookswapx.dao.ReviewDAO;
import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.Notification;
import com.bookswapx.model.Review;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/review/add")
public class ReviewServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ReviewDAO reviewDAO = new ReviewDAO();
	private UserDAO userDAO = new UserDAO();
	private NotificationDAO notificationDAO = new NotificationDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String userIdParam = request.getParameter("userId");
		String transactionIdParam = request.getParameter("transactionId");

		if (userIdParam == null || userIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/user/transactions");
			return;
		}

		int reviewedUserId = Integer.parseInt(userIdParam);

		if (reviewedUserId == loggedInUser.getUserId()) {
			response.sendRedirect(request.getContextPath() + "/user/transactions?error=selfreview");
			return;
		}

		User reviewedUser = userDAO.getUserById(reviewedUserId);
		request.setAttribute("reviewedUser", reviewedUser);
		request.setAttribute("transactionId", transactionIdParam);

		request.getRequestDispatcher("/views/review/review.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String reviewedUserIdParam = request.getParameter("reviewedUserId");
		String ratingParam = request.getParameter("rating");
		String comment = request.getParameter("comment") != null ? request.getParameter("comment").trim() : "";

		if (reviewedUserIdParam == null || ratingParam == null || ratingParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/user/transactions?error=invalid");
			return;
		}

		int reviewedUserId = Integer.parseInt(reviewedUserIdParam);

		int rating;
		try {
			rating = Integer.parseInt(ratingParam);
			if (rating < 1 || rating > 5)
				throw new NumberFormatException();
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/user/transactions?error=invalidrating");
			return;
		}

		if (reviewedUserId == loggedInUser.getUserId()) {
			response.sendRedirect(request.getContextPath() + "/user/transactions?error=selfreview");
			return;
		}

		Review review = new Review();
		review.setReviewerId(loggedInUser.getUserId());
		review.setReviewedUserId(reviewedUserId);
		review.setRating(rating);
		review.setComment(comment);
		boolean success = reviewDAO.addReview(review);

		if (success) {
			double newScore = reviewDAO.getAverageRating(reviewedUserId);
			userDAO.updateTrustScore(reviewedUserId, newScore);

			Notification notification = new Notification();
			notification.setUserId(reviewedUserId);
			notification.setType("NEW_REVIEW");
			notification.setContent(loggedInUser.getUsername() + " gave you a " + rating + " star review!");
			notification.setRelatedId(loggedInUser.getUserId());
			notificationDAO.saveNotification(notification);

			response.sendRedirect(request.getContextPath() + "/user/transactions?success=reviewed");
		} else {
			response.sendRedirect(request.getContextPath() + "/user/transactions?error=reviewfailed");
		}
	}
}