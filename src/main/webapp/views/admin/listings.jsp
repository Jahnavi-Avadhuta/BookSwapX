<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Listing"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<Listing> listings = (List<Listing>) request.getAttribute("listings");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-list-ul"></i> Manage Listings
	</h4>

	<%
	if (request.getParameter("success") != null) {
	%>
	<div class="alert alert-success">Action performed successfully!</div>
	<%
	}
	%>

	<table class="table table-striped table-hover">
		<thead class="table-dark">
			<tr>
				<th>ID</th>
				<th>Book Title</th>
				<th>Posted By</th>
				<th>Type</th>
				<th>Price</th>
				<th>Status</th>
				<th>Deleted</th>
				<th>Posted</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (listings != null) {
				for (Listing listing : listings) {
			%>
			<tr class="<%=listing.isDeleted() ? "table-secondary" : ""%>">
				<td>#<%=listing.getListingId()%></td>
				<td><strong> <%=listing.getBookTitle() != null ? listing.getBookTitle() : "N/A"%>
				</strong> <br> <small class="text-muted"> <%=listing.getBookAuthor() != null ? listing.getBookAuthor() : ""%>
				</small></td>
				<td><%=listing.getOwnerName() != null ? listing.getOwnerName() : "User #" + listing.getUserId()%></td>
				<td><span
					class="badge <%="SELL".equals(listing.getType()) ? "bg-success" : "bg-primary"%>">
						<%=listing.getType()%>
				</span></td>
				<td>₹<%=listing.getPrice()%></td>
				<td><span class="badge bg-secondary"> <%=listing.getStatus()%>
				</span></td>
				<td>
					<%
					if (listing.isDeleted()) {
					%> <span class="badge bg-danger">Deleted</span>
					<%
					} else {
					%> <span class="badge bg-success">Active</span> <%
 }
 %>
				</td>
				<td><small><%=listing.getCreatedAt()%></small></td>
				<td>
					<%
					if (!listing.isDeleted()) {
					%>
					<form action="${pageContext.request.contextPath}/admin/listings"
						method="post" class="d-inline">
						<input type="hidden" name="listingId"
							value="<%=listing.getListingId()%>"> <input
							type="hidden" name="action" value="delete">
						<button type="submit" class="btn btn-sm btn-danger"
							onclick="return confirm('Delete this listing?')">
							<i class="bi bi-trash"></i> Delete
						</button>
					</form> <%
 } else {
 %>
					<form action="${pageContext.request.contextPath}/admin/listings"
						method="post" class="d-inline">
						<input type="hidden" name="listingId"
							value="<%=listing.getListingId()%>"> <input
							type="hidden" name="action" value="restore">
						<button type="submit" class="btn btn-sm btn-success">
							<i class="bi bi-arrow-counterclockwise"></i> Restore
						</button>
					</form> <%
 }
 %>
				</td>
			</tr>
			<%
			}
			}
			%>
		</tbody>
	</table>
</div>

<%@ include file="../common/footer.jsp"%>