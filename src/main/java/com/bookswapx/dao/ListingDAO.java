package com.bookswapx.dao;

import com.bookswapx.dao.interfaces.ListingDAOInterface;
import com.bookswapx.db.DBConnection;
import com.bookswapx.model.Listing;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListingDAO implements ListingDAOInterface {

	public boolean addListing(Listing listing) {
		String sql = "INSERT INTO listings (user_id, book_id, type, price, description, meeting_location) VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, listing.getUserId());
			ps.setInt(2, listing.getBookId());
			ps.setString(3, listing.getType());
			ps.setDouble(4, listing.getPrice());
			ps.setString(5, listing.getDescription());
			ps.setString(6, listing.getMeetingLocation());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Listing> getAllActiveListings() {
		List<Listing> listings = new ArrayList<>();
		String sql = "SELECT l.*, b.title, b.author, b.book_condition, " + "b.edition, b.isbn " + "FROM listings l "
				+ "JOIN books b ON l.book_id = b.book_id " + "WHERE l.status = 'AVAILABLE' "
				+ "AND l.is_deleted = false " + "ORDER BY l.created_at DESC";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				listings.add(mapListingWithBook(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listings;
	}

	public List<Listing> getListingsByUser(int userId) {
		List<Listing> listings = new ArrayList<>();
		String sql = "SELECT l.*, b.title, b.author, b.book_condition, b.edition, b.isbn " + "FROM listings l "
				+ "JOIN books b ON l.book_id = b.book_id " + "WHERE l.user_id = ? AND l.is_deleted = false "
				+ "ORDER BY l.created_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				listings.add(mapListingWithBook(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listings;
	}

	public List<Listing> getListingsByType(String type) {
		List<Listing> list = new ArrayList<>();
		String sql = "SELECT * FROM listings WHERE type = ? AND status = 'AVAILABLE' AND is_deleted = false ORDER BY created_at DESC";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, type);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(mapListing(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean softDeleteListing(int listingId) {
		String sql = "UPDATE listings SET is_deleted = true, deleted_at = CURRENT_TIMESTAMP WHERE listing_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, listingId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateListingStatus(int listingId, String status) {
		String sql = "UPDATE listings SET status = ? WHERE listing_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, listingId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public Listing getListingById(int listingId) {
		String sql = "SELECT * FROM listings WHERE listing_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, listingId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return mapListing(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean restoreListing(int listingId) {
		String sql = "UPDATE listings SET is_deleted = false, " + "deleted_at = NULL, status = 'AVAILABLE' "
				+ "WHERE listing_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, listingId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Listing> getAllListingsForAdmin() {
		List<Listing> listings = new ArrayList<>();
		String sql = "SELECT l.*, b.title, b.author, b.book_condition, "
				+ "b.edition, b.isbn, u.username as owner_name " + "FROM listings l "
				+ "JOIN books b ON l.book_id = b.book_id " + "JOIN users u ON l.user_id = u.user_id "
				+ "ORDER BY l.created_at DESC";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Listing listing = mapListingWithBook(rs);
				listing.setOwnerName(rs.getString("owner_name"));
				listings.add(listing);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listings;
	}

	private Listing mapListing(ResultSet rs) throws SQLException {
		Listing l = new Listing();
		l.setListingId(rs.getInt("listing_id"));
		l.setUserId(rs.getInt("user_id"));
		l.setBookId(rs.getInt("book_id"));
		l.setType(rs.getString("type"));
		l.setPrice(rs.getDouble("price"));
		l.setStatus(rs.getString("status"));
		l.setDeleted(rs.getBoolean("is_deleted"));
		l.setDeletedAt(rs.getTimestamp("deleted_at"));
		l.setDescription(rs.getString("description"));
		l.setMeetingLocation(rs.getString("meeting_location"));
		l.setCreatedAt(rs.getTimestamp("created_at"));
		return l;
	}

	private Listing mapListingWithBook(ResultSet rs) throws SQLException {
		Listing listing = new Listing();
		listing.setListingId(rs.getInt("listing_id"));
		listing.setUserId(rs.getInt("user_id"));
		listing.setBookId(rs.getInt("book_id"));
		listing.setType(rs.getString("type"));
		listing.setPrice(rs.getDouble("price"));
		listing.setStatus(rs.getString("status"));
		listing.setCreatedAt(rs.getTimestamp("created_at"));
		listing.setDescription(rs.getString("description"));
		listing.setMeetingLocation(rs.getString("meeting_location"));
		listing.setDeleted(rs.getBoolean("is_deleted"));
		listing.setBookTitle(rs.getString("title"));
		listing.setBookAuthor(rs.getString("author"));
		listing.setBookCondition(rs.getString("book_condition"));
		listing.setBookEdition(rs.getString("edition"));
		listing.setBookIsbn(rs.getString("isbn"));
		return listing;
	}
}