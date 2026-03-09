package com.bookswapx.servlet.user;

import com.bookswapx.dao.TransactionDAO;
import com.bookswapx.model.Transaction;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/transactions")
public class TransactionServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private TransactionDAO transactionDAO = new TransactionDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		List<Transaction> transactions = transactionDAO.getTransactionsByUser(loggedInUser.getUserId());

		request.setAttribute("transactions", transactions);

		request.getRequestDispatcher("/views/user/transactions.jsp").forward(request, response);
	}
}