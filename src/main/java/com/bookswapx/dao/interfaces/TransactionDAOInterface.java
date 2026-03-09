package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Transaction;
import java.util.List;

public interface TransactionDAOInterface {
	boolean addTransaction(Transaction transaction);

	List<Transaction> getTransactionsByUser(int userId);
}