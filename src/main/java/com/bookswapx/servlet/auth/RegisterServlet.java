package com.bookswapx.servlet.auth;

import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.User;
import com.bookswapx.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username") != null ? request.getParameter("username").trim() : "";
		String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
		String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
		String location = request.getParameter("location") != null ? request.getParameter("location").trim() : "";

		if (username.isEmpty() || email.isEmpty() || password.isEmpty() || location.isEmpty()) {
			request.setAttribute("error", "All fields are required.");
			request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
			return;
		}

		if (userDAO.emailExists(email)) {
			request.setAttribute("error", "Email already registered. Please login.");
			request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
			return;
		}

		String hashedPassword = PasswordUtil.hashPassword(password);

		User user = new User();
		user.setUsername(username);
		user.setEmail(email);
		user.setPassword(hashedPassword);
		user.setLocation(location);

		boolean success = userDAO.registerUser(user);

		if (success) {
			response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?success=registered");
		} else {
			request.setAttribute("error", "Registration failed. Please try again.");
			request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
		}
	}
}