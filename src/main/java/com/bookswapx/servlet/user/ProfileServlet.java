package com.bookswapx.servlet.user;

import com.bookswapx.dao.ReviewDAO;
import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/user/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();
	private ReviewDAO reviewDAO = new ReviewDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		User user = userDAO.getUserById(loggedInUser.getUserId());
		double avgRating = reviewDAO.getAverageRating(loggedInUser.getUserId());

		request.setAttribute("user", user);
		request.setAttribute("reviews", reviewDAO.getReviewsForUser(loggedInUser.getUserId()));
		request.setAttribute("avgRating", avgRating);

		request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		String location = request.getParameter("location");

		String profilePictureName = loggedInUser.getProfilePicture();

		try {
			Part filePart = request.getPart("profilePicture");
			if (filePart != null && filePart.getSize() > 0) {
				String fileName = filePart.getSubmittedFileName();
				String extension = fileName.substring(fileName.lastIndexOf("."));
				String newFileName = "user_" + loggedInUser.getUserId() + "_" + UUID.randomUUID().toString()
						+ extension;
				String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator
						+ "profile_pictures";

				File uploadFolder = new File(uploadDir);
				if (!uploadFolder.exists()) {
					uploadFolder.mkdirs();
				}

				try (InputStream input = filePart.getInputStream()) {
					Files.copy(input, Paths.get(uploadDir + File.separator + newFileName),
							StandardCopyOption.REPLACE_EXISTING);
				}

				profilePictureName = newFileName;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		boolean updated = userDAO.updateProfile(loggedInUser.getUserId(), location, profilePictureName);

		if (updated) {
			User updatedUser = userDAO.getUserById(loggedInUser.getUserId());
			session.setAttribute("loggedInUser", updatedUser);
			response.sendRedirect(request.getContextPath() + "/user/profile?success=updated");
		} else {
			request.setAttribute("user", userDAO.getUserById(loggedInUser.getUserId()));
			request.setAttribute("reviews", reviewDAO.getReviewsForUser(loggedInUser.getUserId()));
			request.setAttribute("avgRating", reviewDAO.getAverageRating(loggedInUser.getUserId()));
			request.setAttribute("error", "Failed to update profile. Please try again.");
			request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
		}
	}
}