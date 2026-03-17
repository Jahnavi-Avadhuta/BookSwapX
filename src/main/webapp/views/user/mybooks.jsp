<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Listing"%>
<%@ page import="com.bookswapx.model.Wishlist"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<Listing> sellListings = (List<Listing>) request.getAttribute("sellListings");
List<Listing> buyListings = (List<Listing>) request.getAttribute("buyListings");
List<Wishlist> wishlist = (List<Wishlist>) request.getAttribute("wishlist");
%>

<div class="container mt-4">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h4>My Books</h4>
		<a href="${pageContext.request.contextPath}/listing/post"
			class="btn btn-dark"> <i class="bi bi-plus-circle"></i> Post New
			Listing
		</a>
	</div>

	<%
	if ("posted".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">Listing posted successfully!</div>
	<%
	}
	%>
	<%
	if ("deleted".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-warning">Listing deleted successfully.</div>
	<%
	}
	%>

	<h5 class="mt-3">
		<i class="bi bi-tag"></i> Books I'm Selling
	</h5>
	<%
	if (sellListings == null || sellListings.isEmpty()) {
	%>
	<p class="text-muted">You have no sell listings.</p>
	<%
	} else {
	%>
	<div class="row">
		<%
		for (Listing listing : sellListings) {
		%>
		<div class="col-md-4 mb-3">
			<div class="card h-100 shadow-sm">
				<div class="card-body">
					<h6 class="card-title fw-bold">
						<%=listing.getBookTitle() != null ? listing.getBookTitle() : "Listing #" + listing.getListingId()%>
					</h6>
					<p class="text-muted small mb-1">
						<i class="bi bi-person"></i>
						<%=listing.getBookAuthor() != null ? listing.getBookAuthor() : ""%>
					</p>
					<span class="badge bg-success">SELL</span> <span
						class="badge bg-secondary"><%=listing.getStatus()%></span>
					<p class="mt-2 mb-1">
						<strong>Price:</strong> <span class="text-success">₹<%=listing.getPrice()%></span>
					</p>
					<%
					if (listing.getDescription() != null && !listing.getDescription().isEmpty()) {
					%>
					<p class="mb-1">
						<small><%=listing.getDescription()%></small>
					</p>
					<%
					}
					%>
					<p class="mb-0">
						<small class="text-muted"> <i class="bi bi-geo-alt"></i> <%=listing.getMeetingLocation() != null ? listing.getMeetingLocation() : ""%>
						</small>
					</p>
				</div>
				<div class="card-footer">
					<form action="${pageContext.request.contextPath}/listing/delete"
						method="post">
						<input type="hidden" name="listingId"
							value="<%=listing.getListingId()%>">
						<button type="submit" class="btn btn-sm btn-danger"
							onclick="return confirm('Delete this listing?')">
							<i class="bi bi-trash"></i> Delete
						</button>
					</form>
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

	<h5 class="mt-4">
		<i class="bi bi-cart"></i> Books I'm Looking For
	</h5>
	<%
	if (buyListings == null || buyListings.isEmpty()) {
	%>
	<p class="text-muted">You have no buy listings.</p>
	<%
	} else {
	%>
	<div class="row">
		<%
		for (Listing listing : buyListings) {
		%>
		<div class="col-md-4 mb-3">
			<div class="card h-100 shadow-sm">
				<div class="card-body">
					<h6 class="card-title fw-bold">
						<%=listing.getBookTitle() != null ? listing.getBookTitle() : "Listing #" + listing.getListingId()%>
					</h6>
					<p class="text-muted small mb-1">
						<i class="bi bi-person"></i>
						<%=listing.getBookAuthor() != null ? listing.getBookAuthor() : ""%>
					</p>
					<span class="badge bg-primary">BUY</span> <span
						class="badge bg-secondary"><%=listing.getStatus()%></span>
					<%
					if (listing.getDescription() != null && !listing.getDescription().isEmpty()) {
					%>
					<p class="mt-2 mb-1">
						<small><%=listing.getDescription()%></small>
					</p>
					<%
					}
					%>
				</div>
				<div class="card-footer">
					<form action="${pageContext.request.contextPath}/listing/delete"
						method="post">
						<input type="hidden" name="listingId"
							value="<%=listing.getListingId()%>">
						<button type="submit" class="btn btn-sm btn-danger"
							onclick="return confirm('Delete this listing?')">
							<i class="bi bi-trash"></i> Delete
						</button>
					</form>
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

	<h5 class="mt-4">
		<i class="bi bi-heart"></i> My Wishlist
	</h5>
	<%
	if (wishlist == null || wishlist.isEmpty()) {
	%>
	<p class="text-muted">Your wishlist is empty.</p>
	<%
	} else {
	%>
	<div class="row">
		<%
		for (Wishlist wish : wishlist) {
		%>
		<div class="col-md-3 mb-3">
			<div class="card shadow-sm">
				<div class="card-body text-center">
					<i class="bi bi-book fs-1 text-muted"></i>
					<p class="mt-2">
						Book #<%=wish.getBookId()%></p>
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

<%-- Completed Listings Section --%>
<%
List<Listing> completedListings = (List<Listing>) request.getAttribute("completedListings");
if (completedListings != null && !completedListings.isEmpty()) {
%>
<div class="container mt-4">
	<h5>
		<i class="bi bi-check-circle text-success"></i> Completed Listings
	</h5>
	<div class="row">
		<%
		for (Listing cl : completedListings) {
		%>
		<div class="col-md-4 mb-3">
			<div class="card h-100 shadow-sm border-success">
				<div class="card-body">
					<h6 class="card-title fw-bold">
						<%=cl.getBookTitle() != null ? cl.getBookTitle() : "N/A"%>
					</h6>
					<p class="text-muted small mb-1">
						<i class="bi bi-person"></i>
						<%=cl.getBookAuthor() != null ? cl.getBookAuthor() : ""%>
					</p>
					<span class="badge bg-secondary"> <%=cl.getType()%>
					</span>
					<%
					if ("EXCHANGED".equals(cl.getStatus())) {
					%>
					<span class="badge bg-success">Exchanged</span>
					<p class="text-success mt-2 mb-0 small">
						<i class="bi bi-arrow-left-right"></i> Successfully Exchanged!
					</p>
					<%
					} else if ("SOLD".equals(cl.getStatus())) {
					%>
					<span class="badge bg-primary">Sold</span>
					<p class="text-primary mt-2 mb-0 small">
						<i class="bi bi-cart-check"></i> Successfully Sold!
					</p>
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
</div>
<%
}
%>

<%@ include file="../common/footer.jsp"%>