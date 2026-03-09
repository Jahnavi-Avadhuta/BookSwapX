package com.bookswapx.dao.interfaces;

import com.bookswapx.model.PotentialMatch;
import java.util.List;

public interface MatchDAOInterface {
	List<PotentialMatch> getMatchesForUser(int userId);

	boolean updateMatchStatus(int matchId, String status);

	PotentialMatch getMatchById(int matchId);
}