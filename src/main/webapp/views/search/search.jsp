<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Listing"%>
<%@ page import="com.bookswapx.model.Category"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%-- Wishlist alerts — ADD RIGHT HERE --%>
<div class="container mt-2">
	<%
	if ("added".equals(request.getParameter("wishlist"))) {
	%>
	<div class="alert alert-success alert-dismissible fade show">
		<i class="bi bi-heart-fill"></i> Added to wishlist!
		<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	</div>
	<%
	}
	%>
	<%
	if ("already".equals(request.getParameter("wishlist"))) {
	%>
	<div class="alert alert-warning alert-dismissible fade show">
		<i class="bi bi-exclamation-triangle"></i> Already in your wishlist!
		<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	</div>
	<%
	}
	%>
</div>

<%
List<Listing> listings = (List<Listing>) request.getAttribute("listings");
List<Category> categories = (List<Category>) request.getAttribute("categories");
String keyword = request.getAttribute("keyword") != null ? (String) request.getAttribute("keyword") : "";
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-search"></i> Browse Books
	</h4>

	<div class="card shadow-sm mb-4">
		<div class="card-body">
			<form action="${pageContext.request.contextPath}/search" method="get">
				<div class="row g-2">
					<div class="col-md-4">
						<input type="text" name="keyword" class="form-control"
							placeholder="Search by title or author..." value="<%=keyword%>">
					</div>
					<div class="col-md-2">
						<select name="category" class="form-select">
							<option value="">All Categories</option>
							<%
							if (categories != null) {
								for (Category cat : categories) {
							%>
							<option value="<%=cat.getCategoryId()%>">
								<%=cat.getCategoryName()%>
							</option>
							<%
							}
							}
							%>
						</select>
					</div>
					<div class="col-md-2">
						<select name="type" class="form-select">
							<option value="">All Types</option>
							<option value="SELL">Selling</option>
							<option value="BUY">Looking For</option>
						</select>
					</div>
					<div class="col-md-2">
						<select name="sortBy" class="form-select">
							<option value="newest">Newest First</option>
							<option value="price_asc">Price: Low to High</option>
							<option value="price_desc">Price: High to Low</option>
						</select>
					</div>
					<div class="col-md-2">
						<button type="submit" class="btn btn-dark w-100">
							<i class="bi bi-search"></i> Search
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%
	if (listings == null || listings.isEmpty()) {
	%>
	<div class="text-center mt-5">
		<i class="bi bi-book fs-1 text-muted"></i>
		<p class="text-muted mt-3">No listings found.</p>
	</div>
	<%
	} else {
	%>
	<p class="text-muted"><%=listings.size()%>
		listing(s) found
	</p>
	<div class="row">
		<%
		for (Listing listing : listings) {
		%>
		<div class="col-md-4 mb-4">
			<div class="card h-100 shadow-sm">
				<div class="card-body">
					<div class="d-flex justify-content-between mb-2">
						<span
							class="badge <%="SELL".equals(listing.getType()) ? "bg-success" : "bg-primary"%>">
							<%=listing.getType()%>
						</span> <span
							class="badge <%="NEW".equals(listing.getBookCondition()) ? "bg-success"
		: "GOOD".equals(listing.getBookCondition()) ? "bg-warning text-dark" : "bg-secondary"%>">
							<%=listing.getBookCondition() != null ? listing.getBookCondition() : ""%>
						</span>
					</div>

					<h6 class="card-title fw-bold">
						<%=listing.getBookTitle() != null ? listing.getBookTitle() : "Unknown Title"%>
					</h6>
					<p class="text-muted small mb-1">
						<i class="bi bi-person"></i>
						<%=listing.getBookAuthor() != null ? listing.getBookAuthor() : "Unknown Author"%>
					</p>
					<%
					if (listing.getBookEdition() != null && !listing.getBookEdition().isEmpty()) {
					%>
					<p class="text-muted small mb-1">
						<i class="bi bi-bookmark"></i>
						<%=listing.getBookEdition()%>
					</p>
					<%
					}
					%>

					<p class="fw-bold mt-2 mb-1">
						<%
						if ("BUY".equals(listing.getType())) {
						%>
						<span class="text-primary">Looking to Buy</span>
						<%
						} else {
						%>
						<span class="text-success">₹<%=listing.getPrice()%></span>
						<%
						}
						%>
					</p>

					<%
					if (listing.getDescription() != null && !listing.getDescription().isEmpty()) {
					%>
					<p class="card-text text-muted small">
						<%=listing.getDescription()%>
					</p>
					<%
					}
					%>

					<p class="text-muted small mb-0">
						<i class="bi bi-geo-alt"></i>
						<%=listing.getMeetingLocation() != null ? listing.getMeetingLocation() : "Not specified"%>
					</p>
				</div>
				<div class="card-footer d-flex gap-2 flex-wrap">
					<a
						href="${pageContext.request.contextPath}/listing/detail?id=<%= listing.getListingId() %>"
						class="btn btn-sm btn-dark"> <i class="bi bi-eye"></i> View
						Details
					</a>
					<%
					User searchPageUser = (User) session.getAttribute("loggedInUser");
					if (searchPageUser != null && "USER".equals(searchPageUser.getRole())) {
					%>
					<a
						href="${pageContext.request.contextPath}/messages?with=<%= listing.getUserId() %>"
						class="btn btn-sm btn-outline-dark"> <i class="bi bi-chat"></i>
						Message
					</a>
					<form action="${pageContext.request.contextPath}/wishlist"
						method="post" class="d-inline">
						<input type="hidden" name="action" value="add"> <input
							type="hidden" name="bookId" value="<%=listing.getBookId()%>">
						<button type="submit" class="btn btn-sm btn-outline-warning">
							<i class="bi bi-heart"></i> Wishlist
						</button>
					</form>

					<%-- ADD BUY NOW BUTTON HERE — only for SELL listings --%>
					<%
					if ("SELL".equals(listing.getType())) {
					%>
					<form action="${pageContext.request.contextPath}/listing/buy"
						method="post" class="d-inline">
						<input type="hidden" name="listingId"
							value="<%=listing.getListingId()%>">
						<button type="submit" class="btn btn-sm btn-success"
							onclick="return confirm('Confirm purchase of this book for ₹<%=listing.getPrice()%>?')">
							<i class="bi bi-cart"></i> Buy Now
						</button>
					</form>
					<%
					}
					%>

					<%
					}
					%>
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>
	<%
	}
	%>
</div>

<%@ include file="../common/footer.jsp"%>