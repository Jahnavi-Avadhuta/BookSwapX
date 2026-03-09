<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Transaction"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
User currentUser = (User) session.getAttribute("loggedInUser");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-clock-history"></i> Transaction History
	</h4>

	<%-- ADD HERE --%>
	<%
	if ("reviewed".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">
		<i class="bi bi-star-fill"></i> Review submitted successfully!
	</div>
	<%
	}
	%>
	<%
	if ("purchased".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">
		<i class="bi bi-check-circle"></i> Purchase successful! Contact the
		seller to arrange meetup.
	</div>
	<%
	}
	%>
	<%
	if ("selfreview".equals(request.getParameter("error"))) {
	%>
	<div class="alert alert-danger">You cannot review yourself!</div>
	<%
	}
	%>
	<%
	if ("reviewfailed".equals(request.getParameter("error"))) {
	%>
	<div class="alert alert-danger">Failed to submit review. You may
		have already reviewed this person.</div>
	<%
	}
	%>

	<%
	if ("purchased".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">
		<i class="bi bi-check-circle"></i> Purchase successful! Contact the
		seller to arrange meetup.
	</div>
	<%
	}
	%>

	<%
	if (transactions == null || transactions.isEmpty()) {
	%>
	<div class="text-center mt-5">
		<i class="bi bi-clock-history fs-1 text-muted"></i>
		<p class="text-muted mt-3">No transactions yet.</p>
		<a href="${pageContext.request.contextPath}/search"
			class="btn btn-dark">Browse Books</a>
	</div>
	<%
	} else {
	%>
	<div class="table-responsive">
		<table class="table table-striped table-hover">
			<thead class="table-dark">
				<tr>
					<th>Book</th>
					<th>Type</th>
					<th>Buyer</th>
					<th>Seller</th>
					<th>Price</th>
					<th>Date</th>
					<th>Review</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Transaction t : transactions) {
					boolean isBuyer = t.getBuyerId() == currentUser.getUserId();
				%>
				<tr>
					<td><strong> <%=t.getBookTitle() != null ? t.getBookTitle() : "N/A"%>
					</strong> <br> <small class="text-muted"> <%=t.getBookAuthor() != null ? t.getBookAuthor() : ""%>
					</small></td>
					<td>
						<%
						if (t.isExchange()) {
						%> <span class="badge bg-success"> <i
							class="bi bi-arrow-left-right"></i> Exchange
					</span> <%
 } else {
 %> <span class="badge bg-primary"> <i class="bi bi-cart"></i>
							Sale
					</span> <%
 }
 %>
					</td>
					<td><%=t.getBuyerName()%> <%
 if (isBuyer) {
 %> <span class="badge bg-info">You</span> <%
 }
 %></td>
					<td><%=t.getSellerName()%> <%
 if (!isBuyer) {
 %> <span class="badge bg-info">You</span> <%
 }
 %></td>
					<td>
						<%
						if (t.isExchange()) {
						%> <span class="text-success fw-bold">FREE</span> <%
 } else {
 %> <span class="fw-bold">₹<%=t.getPrice()%></span> <%
 }
 %>
					</td>
					<td><small><%=t.getCompletedAt()%></small></td>
					<td>
						<%
						int reviewTargetId = t.getBuyerId() == currentUser.getUserId() ? t.getSellerId() : t.getBuyerId();
						String reviewTargetName = t.getBuyerId() == currentUser.getUserId() ? t.getSellerName() : t.getBuyerName();
						%> <a
						href="${pageContext.request.contextPath}/review/add?userId=<%= reviewTargetId %>&transactionId=<%= t.getTransactionId() %>"
						class="btn btn-sm btn-warning"> <i class="bi bi-star"></i>
							Review <%=reviewTargetName%>
					</a>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<%
	}
	%>
</div>

<%@ include file="../common/footer.jsp"%>