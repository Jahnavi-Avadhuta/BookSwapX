package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Category;
import java.util.List;

public interface CategoryDAOInterface {
	List<Category> getAllCategories();

	boolean addCategory(String categoryName);

	boolean deleteCategory(int categoryId);
}