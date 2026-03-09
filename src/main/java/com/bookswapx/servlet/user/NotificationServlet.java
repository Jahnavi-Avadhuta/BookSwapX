package com.bookswapx.servlet.user;

import com.bookswapx.dao.NotificationDAO;
import com.bookswapx.model.Notification;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/notifications")
public class NotificationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private NotificationDAO notificationDAO = new NotificationDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		notificationDAO.markAllAsRead(loggedInUser.getUserId());

		session.setAttribute("unreadNotifications", 0);

		List<Notification> notifications = notificationDAO.getNotificationsForUser(loggedInUser.getUserId());

		request.setAttribute("notifications", notifications);

		request.getRequestDispatcher("/views/user/notifications.jsp").forward(request, response);
	}
}