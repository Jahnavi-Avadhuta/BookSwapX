package com.bookswapx.dao.interfaces;

import com.bookswapx.model.ExchangeRequest;
import java.util.List;

public interface ExchangeDAOInterface {
	boolean createRequest(ExchangeRequest request);

	boolean updateRequestStatus(int requestId, String status);

	List<ExchangeRequest> getRequestsForUser(int userId);

	ExchangeRequest getRequestById(int requestId);

	ExchangeRequest getRequestByMatchId(int matchId);
}