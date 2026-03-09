package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Listing;
import java.util.List;

public interface ListingDAOInterface {
	boolean addListing(Listing listing);

	boolean restoreListing(int listingId);

	List<Listing> getAllListingsForAdmin();

	List<Listing> getAllActiveListings();

	List<Listing> getListingsByUser(int userId);

	List<Listing> getListingsByType(String type);

	boolean softDeleteListing(int listingId);

	boolean updateListingStatus(int listingId, String status);

	Listing getListingById(int listingId);
}