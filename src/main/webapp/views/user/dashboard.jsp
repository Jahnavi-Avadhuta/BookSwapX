<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="com.bookswapx.model.Listing"%>
<%@ page import="com.bookswapx.model.Notification"%>
<%@ page import="com.bookswapx.model.Transaction"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
User currentUser = (User) session.getAttribute("loggedInUser");
List<Listing> myListings = (List<Listing>) request.getAttribute("myListings");
List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
List<Transaction> recentTransactions = (List<Transaction>) request.getAttribute("recentTransactions");
int unreadNotifications = request.getAttribute("unreadNotifications") != null
		? ((Number) request.getAttribute("unreadNotifications")).intValue()
		: 0;
int unreadMessages = request.getAttribute("unreadMessages") != null ? (int) request.getAttribute("unreadMessages") : 0;
%>

<div class="container mt-4">
	<div class="row mb-4">
		<div class="col">
			<div class="card bg-dark text-white">
				<div class="card-body">
					<h4 class="card-title">
						Welcome back,
						<%=currentUser.getUsername()%>! <span
							class="badge bg-warning text-dark ms-2"> <i
							class="bi bi-star-fill"></i> Trust Score: <%=currentUser.getTrustScore()%>
						</span>
					</h4>
					<p class="card-text">
						<i class="bi bi-geo-alt"></i>
						<%=currentUser.getLocation()%>
					</p>
				</div>
			</div>
		</div>
	</div>

	<div class="row mb-4">
		<div class="col-md-3">
			<div class="card text-center border-primary">
				<div class="card-body">
					<h2 class="text-primary"><%=myListings != null ? myListings.size() : 0%></h2>
					<p class="mb-0">Active Listings</p>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card text-center border-success">
				<div class="card-body">
					<h2 class="text-success"><%=recentTransactions != null ? recentTransactions.size() : 0%></h2>
					<p class="mb-0">Transactions</p>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card text-center border-warning">
				<div class="card-body">
					<h2 class="text-warning"><%=unreadNotifications%></h2>
					<p class="mb-0">Notifications</p>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card text-center border-info">
				<div class="card-body">
					<h2 class="text-info"><%=unreadMessages%></h2>
					<p class="mb-0">Unread Messages</p>
				</div>
			</div>
		</div>
	</div>

	<div class="row mb-4">
		<div class="col">
			<h5>Quick Actions</h5>
			<a href="${pageContext.request.contextPath}/listing/post"
				class="btn btn-dark me-2"> <i class="bi bi-plus-circle"></i>
				Post New Listing
			</a> <a href="${pageContext.request.contextPath}/search"
				class="btn btn-outline-dark me-2"> <i class="bi bi-search"></i>
				Browse Books
			</a> <a href="${pageContext.request.contextPath}/exchange/matches"
				class="btn btn-outline-success"> <i
				class="bi bi-arrow-left-right"></i> View Matches
			</a>
		</div>
	</div>

	<div class="row mb-4">
		<div class="col">
			<h5>Recent Notifications</h5>
			<%
			if (notifications == null || notifications.isEmpty()) {
			%>
			<p class="text-muted">No notifications yet.</p>
			<%
			} else {
			%>
			<div class="list-group">
				<%
				int count = 0;
				for (Notification notif : notifications) {
					if (count >= 5)
						break;
				%>
				<div
					class="list-group-item <%=notif.isRead() ? "" : "list-group-item-warning"%>">
					<i class="bi bi-bell"></i>
					<%=notif.getContent()%>
					<small class="text-muted float-end"><%=notif.getCreatedAt()%></small>
				</div>
				<%
				count++;
				}
				%>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<div class="row">
		<div class="col">
			<h5>Recent Transactions</h5>
			<%
			if (recentTransactions == null || recentTransactions.isEmpty()) {
			%>
			<p class="text-muted">No transactions yet.</p>
			<%
			} else {
			%>
			<table class="table table-striped">
				<thead class="table-dark">
					<tr>
						<th>Transaction ID</th>
						<th>Type</th>
						<th>Price</th>
						<th>Date</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Transaction tx : recentTransactions) {
					%>
					<tr>
						<td>#<%=tx.getTransactionId()%></td>
						<td><span
							class="badge <%=tx.isExchange() ? "bg-success" : "bg-primary"%>">
								<%=tx.getTransactionType()%>
						</span></td>
						<td>
							<%
							if (tx.isExchange()) {
							%> <span class="text-success fw-bold">FREE</span> <%
 } else {
 %> ₹<%=tx.getPrice()%> <%
 }
 %>
						</td>
						<td><%=tx.getCompletedAt()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			}
			%>
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp"%>