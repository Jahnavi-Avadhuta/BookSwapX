package com.bookswapx.servlet.message;

import com.bookswapx.dao.MessageDAO;
import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.Message;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private MessageDAO messageDAO = new MessageDAO();
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String receiverIdParam = request.getParameter("with");

		if (receiverIdParam != null) {
			int receiverId = Integer.parseInt(receiverIdParam);
			User receiver = userDAO.getUserById(receiverId);

			request.setAttribute("conversation", messageDAO.getConversation(loggedInUser.getUserId(), receiverId));
			request.setAttribute("receiver", receiver);

			messageDAO.markAsRead(receiverId, loggedInUser.getUserId());
		}

		request.setAttribute("conversations", messageDAO.getAllConversations(loggedInUser.getUserId()));

		request.getRequestDispatcher("/views/message/inbox.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		int receiverId = Integer.parseInt(request.getParameter("receiverId"));
		String messageText = request.getParameter("message").trim();

		if (!messageText.isEmpty()) {
			Message message = new Message();
			message.setSenderId(loggedInUser.getUserId());
			message.setReceiverId(receiverId);
			message.setMessage(messageText);
			messageDAO.sendMessage(message);
		}

		response.sendRedirect(request.getContextPath() + "/messages?with=" + receiverId);
	}
}