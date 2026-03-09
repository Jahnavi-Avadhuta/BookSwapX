package com.bookswapx.servlet.admin;

import com.bookswapx.dao.ListingDAO;
import com.bookswapx.model.Listing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/listings")
public class AdminListingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO = new ListingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Listing> listings = listingDAO.getAllListingsForAdmin();
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("/views/admin/listings.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String listingIdParam = request.getParameter("listingId");

        if (listingIdParam == null || listingIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/listings");
            return;
        }

        int listingId = Integer.parseInt(listingIdParam);

        if ("delete".equals(action)) {
            listingDAO.softDeleteListing(listingId);
        } else if ("restore".equals(action)) {
            listingDAO.restoreListing(listingId);
        }

        response.sendRedirect(request.getContextPath() +
                "/admin/listings?success=done");
    }
}