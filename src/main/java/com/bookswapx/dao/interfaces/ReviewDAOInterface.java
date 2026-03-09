package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Review;
import java.util.List;

public interface ReviewDAOInterface {
	boolean addReview(Review review);

	List<Review> getReviewsForUser(int userId);

	double getAverageRating(int userId);
}