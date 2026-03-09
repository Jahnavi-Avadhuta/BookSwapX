package com.bookswapx.servlet.admin;

import com.bookswapx.dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();
	private ListingDAO listingDAO = new ListingDAO();
	private ReportDAO reportDAO = new ReportDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("totalUsers", userDAO.getAllUsers().size());
		request.setAttribute("activeListings", listingDAO.getAllActiveListings().size());
		request.setAttribute("pendingReports", reportDAO.getAllPendingReports().size());
		request.setAttribute("allUsers", userDAO.getAllUsers());
		request.setAttribute("pendingReportsList", reportDAO.getAllPendingReports());

		request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
	}
}