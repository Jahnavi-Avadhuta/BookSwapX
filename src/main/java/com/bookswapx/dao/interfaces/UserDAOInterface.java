package com.bookswapx.dao.interfaces;

import com.bookswapx.model.User;
import java.util.List;

public interface UserDAOInterface {
	boolean registerUser(User user);

	User getUserByEmail(String email);

	User getUserById(int userId);

	boolean updateProfile(int userId, String location, String profilePicture);

	void updateLastLogin(int userId);

	boolean updateTrustScore(int userId, double score);

	boolean setUserActiveStatus(int userId, boolean isActive);

	List<User> getAllUsers();

	boolean emailExists(String email);
}