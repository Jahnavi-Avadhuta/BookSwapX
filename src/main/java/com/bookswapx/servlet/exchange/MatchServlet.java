package com.bookswapx.servlet.exchange;

import com.bookswapx.dao.MatchDAO;
import com.bookswapx.dao.NotificationDAO;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/exchange/matches")
public class MatchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private MatchDAO matchDAO = new MatchDAO();
	private NotificationDAO notificationDAO = new NotificationDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		int userId = loggedInUser.getUserId();

		request.setAttribute("matches", matchDAO.getMatchesForUser(userId));

		notificationDAO.markAllAsRead(userId);

		request.getRequestDispatcher("/views/exchange/matches.jsp").forward(request, response);
	}
}