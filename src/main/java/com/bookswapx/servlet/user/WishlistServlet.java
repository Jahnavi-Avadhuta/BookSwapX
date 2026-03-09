package com.bookswapx.servlet.user;

import com.bookswapx.dao.WishlistDAO;
import com.bookswapx.model.User;
import com.bookswapx.model.Wishlist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private WishlistDAO wishlistDAO = new WishlistDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		List<Wishlist> wishlist = wishlistDAO.getWishlistByUser(loggedInUser.getUserId());
		request.setAttribute("wishlist", wishlist);

		request.getRequestDispatcher("/views/user/wishlist.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String action = request.getParameter("action");
		String bookIdParam = request.getParameter("bookId");

		if (bookIdParam == null || bookIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/search");
			return;
		}

		int bookId = Integer.parseInt(bookIdParam);

		if ("add".equals(action)) {
			if (wishlistDAO.isInWishlist(loggedInUser.getUserId(), bookId)) {
				response.sendRedirect(request.getContextPath() + "/search?wishlist=already");
			} else {
				wishlistDAO.addToWishlist(loggedInUser.getUserId(), bookId);
				response.sendRedirect(request.getContextPath() + "/search?wishlist=added");
			}
		} else if ("remove".equals(action)) {
			wishlistDAO.removeFromWishlist(loggedInUser.getUserId(), bookId);
			response.sendRedirect(request.getContextPath() + "/wishlist?success=removed");
		}
	}
}