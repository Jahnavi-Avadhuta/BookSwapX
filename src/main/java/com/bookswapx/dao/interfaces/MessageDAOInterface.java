package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Message;
import java.util.List;

public interface MessageDAOInterface {
	boolean sendMessage(Message message);

	List<Message> getConversation(int userAId, int userBId);

	List<Integer> getConversationUsers(int userId);

	void markAsRead(int senderId, int receiverId);

	int getUnreadCount(int userId);
}