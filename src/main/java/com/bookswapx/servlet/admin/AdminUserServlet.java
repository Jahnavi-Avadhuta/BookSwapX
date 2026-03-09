package com.bookswapx.servlet.admin;

import com.bookswapx.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("users", userDAO.getAllUsers());
		request.getRequestDispatcher("/views/admin/users.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userIdParam = request.getParameter("userId");
		if (userIdParam == null || userIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/admin/users");
			return;
		}
		int userId = Integer.parseInt(userIdParam);
		String action = request.getParameter("action");

		if ("block".equals(action)) {
			userDAO.setUserActiveStatus(userId, false);
		} else if ("unblock".equals(action)) {
			userDAO.setUserActiveStatus(userId, true);
		}

		response.sendRedirect(request.getContextPath() + "/admin/users?success=" + action);
	}
}