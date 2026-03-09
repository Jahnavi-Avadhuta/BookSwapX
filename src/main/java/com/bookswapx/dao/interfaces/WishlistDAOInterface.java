package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Wishlist;
import java.util.List;

public interface WishlistDAOInterface {
	boolean addToWishlist(int userId, int bookId);

	boolean removeFromWishlist(int userId, int bookId);

	List<Wishlist> getWishlistByUser(int userId);

	boolean isInWishlist(int userId, int bookId);
}