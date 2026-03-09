package com.bookswapx.servlet.message;

import com.bookswapx.dao.MessageDAO;
import com.bookswapx.dao.UserDAO;
import com.bookswapx.model.Message;
import com.bookswapx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

		List<Integer> conversationUserIds = messageDAO.getConversationUsers(loggedInUser.getUserId());

		String withParam = request.getParameter("with");
		if (withParam != null && !withParam.isEmpty()) {
			try {
				int otherUserId = Integer.parseInt(withParam);
				if (!conversationUserIds.contains(otherUserId)) {
					conversationUserIds.add(0, otherUserId);
				}
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		List<User> conversationUsers = new ArrayList<>();
		for (int uid : conversationUserIds) {
			User u = userDAO.getUserById(uid);
			if (u != null)
				conversationUsers.add(u);
		}
		request.setAttribute("conversationUsers", conversationUsers);

		if (withParam != null && !withParam.isEmpty()) {
			try {
				int otherUserId = Integer.parseInt(withParam);
				User receiver = userDAO.getUserById(otherUserId);
				if (receiver != null) {
					List<Message> conversation = messageDAO.getConversation(loggedInUser.getUserId(), otherUserId);
					messageDAO.markAsRead(otherUserId, loggedInUser.getUserId());
					request.setAttribute("receiver", receiver);
					request.setAttribute("conversation", conversation);
					int unreadCount = messageDAO.getUnreadCount(loggedInUser.getUserId());
					session.setAttribute("unreadMessages", unreadCount);
				}
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		request.getRequestDispatcher("/views/message/inbox.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		String receiverIdParam = request.getParameter("receiverId");
		String messageText = request.getParameter("message") != null ? request.getParameter("message").trim() : "";

		if (receiverIdParam != null && !messageText.isEmpty()) {
			int receiverId = Integer.parseInt(receiverIdParam);

			Message message = new Message();
			message.setSenderId(loggedInUser.getUserId());
			message.setReceiverId(receiverId);
			message.setMessage(messageText);
			messageDAO.sendMessage(message);

			int newUnreadCount = messageDAO.getUnreadCount(receiverId);
			session.setAttribute("unreadMessages", newUnreadCount);

			response.sendRedirect(request.getContextPath() + "/messages?with=" + receiverId);
		} else {
			response.sendRedirect(request.getContextPath() + "/messages");
		}
	}
}