<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Listing"%>
<%@ page import="com.bookswapx.model.Book"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
Listing listing = (Listing) request.getAttribute("listing");
Book book = (Book) request.getAttribute("book");
User owner = (User) request.getAttribute("owner");
User currentUser = (User) session.getAttribute("loggedInUser");
%>

<div class="container mt-4">
	<%
	if (listing == null || book == null) {
	%>
	<div class="alert alert-danger">Listing not found.</div>
	<%
	} else {
	%>

	<div class="row">
		<!-- Book Details -->
		<div class="col-md-8">
			<div class="card shadow">
				<div
					class="card-header bg-dark text-white d-flex justify-content-between">
					<h5 class="mb-0">
						<i class="bi bi-book"></i>
						<%=book.getTitle()%>
					</h5>
					<span
						class="badge <%="SELL".equals(listing.getType()) ? "bg-success" : "bg-primary"%> fs-6">
						<%=listing.getType()%>
					</span>
				</div>
				<div class="card-body">
					<table class="table table-borderless">
						<tr>
							<td><strong>Author</strong></td>
							<td><%=book.getAuthor() != null ? book.getAuthor() : "N/A"%></td>
						</tr>
						<tr>
							<td><strong>Edition</strong></td>
							<td><%=book.getEdition() != null ? book.getEdition() : "N/A"%></td>
						</tr>
						<tr>
							<td><strong>ISBN</strong></td>
							<td><%=book.getIsbn() != null ? book.getIsbn() : "N/A"%></td>
						</tr>
						<tr>
							<td><strong>Condition</strong></td>
							<td><span
								class="badge
                                    <%="NEW".equals(book.getBookCondition()) ? "bg-success"
		: "GOOD".equals(book.getBookCondition()) ? "bg-warning text-dark" : "bg-secondary"%>">
									<%=book.getBookCondition()%>
							</span></td>
						</tr>
						<tr>
							<td><strong>Price</strong></td>
							<td>
								<%
								if ("BUY".equals(listing.getType())) {
								%> <span
								class="text-primary fw-bold">Looking to Buy</span> <%
 } else {
 %>
								<span class="text-success fw-bold">₹<%=listing.getPrice()%></span>
								<%
								}
								%>
							</td>
						</tr>
						<tr>
							<td><strong>Meeting Location</strong></td>
							<td><i class="bi bi-geo-alt"></i> <%=listing.getMeetingLocation() != null ? listing.getMeetingLocation() : "Not specified"%>
							</td>
						</tr>
						<tr>
							<td><strong>Posted On</strong></td>
							<td><%=listing.getCreatedAt()%></td>
						</tr>
					</table>

					<%
					if (listing.getDescription() != null && !listing.getDescription().isEmpty()) {
					%>
					<div class="mt-3">
						<h6>Description</h6>
						<p class="text-muted"><%=listing.getDescription()%></p>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>

		<div class="col-md-4">
			<div class="card shadow mb-3">
				<div class="card-header bg-dark text-white">
					<h6 class="mb-0">
						<i class="bi bi-person"></i> Posted By
					</h6>
				</div>
				<div class="card-body text-center">
					<img
						src="<%=owner != null && owner.getProfilePicture() != null
		? request.getContextPath() + "/uploads/profile_pictures/" + owner.getProfilePicture()
		: "https://via.placeholder.com/60"%>"
						class="rounded-circle mb-2" width="60" height="60" alt="Profile">
					<h6><%=owner != null ? owner.getUsername() : "Unknown"%></h6>
					<p class="text-muted small">
						<i class="bi bi-geo-alt"></i>
						<%=owner != null ? owner.getLocation() : "N/A"%>
					</p>
					<span class="badge bg-warning text-dark"> <i
						class="bi bi-star-fill"></i> Trust Score: <%=owner != null ? owner.getTrustScore() : 0%>
					</span>
				</div>
			</div>

			<%
			boolean isOwner = currentUser != null && owner != null && currentUser.getUserId() == owner.getUserId();
			%>
			<%
			if (!isOwner) {
			%>
			<div class="card shadow mb-3">
				<div class="card-body d-grid gap-2">
					<a
						href="${pageContext.request.contextPath}/messages?with=<%= owner != null ? owner.getUserId() : "" %>"
						class="btn btn-dark"> <i class="bi bi-chat-dots"></i> Message
						Seller
					</a> <a href="${pageContext.request.contextPath}/exchange/matches"
						class="btn btn-outline-success"> <i
						class="bi bi-arrow-left-right"></i> View My Matches
					</a>
				</div>
			</div>

			<div class="card shadow">
				<div class="card-body">
					<h6 class="text-danger">
						<i class="bi bi-flag"></i> Report this Listing
					</h6>
					<form action="${pageContext.request.contextPath}/report"
						method="post">
						<input type="hidden" name="reportedListingId"
							value="<%=listing.getListingId()%>">
						<div class="mb-2">
							<select name="reason" class="form-select form-select-sm" required>
								<option value="">Select Reason</option>
								<option value="FAKE_LISTING">Fake Listing</option>
								<option value="INAPPROPRIATE">Inappropriate</option>
								<option value="SPAM">Spam</option>
								<option value="OTHER">Other</option>
							</select>
						</div>
						<div class="mb-2">
							<textarea name="description" class="form-control form-control-sm"
								rows="2" placeholder="Additional details..."></textarea>
						</div>
						<button type="submit" class="btn btn-sm btn-danger w-100">
							<i class="bi bi-flag"></i> Submit Report
						</button>
					</form>
				</div>
			</div>
			<%
			} else {
			%>
			<div class="card shadow">
				<div class="card-body d-grid gap-2">
					<form action="${pageContext.request.contextPath}/listing/delete"
						method="post">
						<input type="hidden" name="listingId"
							value="<%=listing.getListingId()%>">
						<button type="submit" class="btn btn-danger w-100"
							onclick="return confirm('Delete this listing?')">
							<i class="bi bi-trash"></i> Delete Listing
						</button>
					</form>
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
</div>

<%@ include file="../common/footer.jsp"%>