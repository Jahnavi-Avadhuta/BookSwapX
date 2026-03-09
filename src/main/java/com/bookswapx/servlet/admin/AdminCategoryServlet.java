package com.bookswapx.servlet.admin;

import com.bookswapx.dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private CategoryDAO categoryDAO = new CategoryDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("categories", categoryDAO.getAllCategories());
		request.getRequestDispatcher("/views/admin/categories.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {
			String categoryName = request.getParameter("categoryName").trim();
			categoryDAO.addCategory(categoryName);
		} else if ("delete".equals(action)) {
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			categoryDAO.deleteCategory(categoryId);
		}

		response.sendRedirect(request.getContextPath() + "/admin/categories");
	}
}