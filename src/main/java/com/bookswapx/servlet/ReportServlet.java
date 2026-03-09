package com.bookswapx.servlet;

import com.bookswapx.dao.ReportDAO;
import com.bookswapx.model.Report;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ReportDAO reportDAO = new ReportDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String listingIdParam = request.getParameter("reportedListingId");
		String reason = request.getParameter("reason");
		String description = request.getParameter("description");

		Report report = new Report();
		report.setReporterId(loggedInUser.getUserId());
		report.setReportedListingId(listingIdParam != null ? Integer.parseInt(listingIdParam) : 0);
		report.setReason(reason);
		report.setDescription(description);

		reportDAO.fileReport(report);

		response.sendRedirect(request.getContextPath() + "/listing/detail?id=" + listingIdParam + "&success=reported");
	}
}