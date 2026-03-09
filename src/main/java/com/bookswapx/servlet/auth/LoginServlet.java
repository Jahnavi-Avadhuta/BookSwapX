package com.bookswapx.servlet.auth;

import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.User;
import com.bookswapx.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
		String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";

		if (email.isEmpty() || password.isEmpty()) {
			request.setAttribute("error", "Email and password are required.");
			request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
			return;
		}

		User user = userDAO.getUserByEmail(email);

		if (user == null) {
			request.setAttribute("error", "No account found with this email.");
			request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
			return;
		}

		if (!user.isActive()) {
			request.setAttribute("error", "Your account has been blocked. Contact admin.");
			request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
			return;
		}

		if (!PasswordUtil.checkPassword(password, user.getPassword())) {
			request.setAttribute("error", "Incorrect password. Please try again.");
			request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
			return;
		}

		userDAO.updateLastLogin(user.getUserId());

		HttpSession session = request.getSession();
		session.setAttribute("loggedInUser", user);
		session.setAttribute("userId", user.getUserId());
		session.setAttribute("username", user.getUsername());
		session.setAttribute("role", user.getRole());

		if ("ADMIN".equals(user.getRole())) {
			response.sendRedirect(request.getContextPath() + "/admin/dashboard");
		} else {
			response.sendRedirect(request.getContextPath() + "/user/dashboard");
		}
	}
}