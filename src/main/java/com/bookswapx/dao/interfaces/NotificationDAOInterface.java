package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Notification;
import java.util.List;

public interface NotificationDAOInterface {
	List<Notification> getNotificationsForUser(int userId);

	int getUnreadCount(int userId);

	void markAllAsRead(int userId);

	boolean saveNotification(Notification notification);
}