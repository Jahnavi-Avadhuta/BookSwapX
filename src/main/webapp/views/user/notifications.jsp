<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Notification"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
User currentUser = (User) session.getAttribute("loggedInUser");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-bell"></i> Notifications
	</h4>

	<%
	if (notifications == null || notifications.isEmpty()) {
	%>
	<div class="text-center mt-5">
		<i class="bi bi-bell-slash fs-1 text-muted"></i>
		<p class="text-muted mt-3">No notifications yet.</p>
	</div>
	<%
	} else {
	%>
	<div class="list-group">
		<%
		for (Notification notif : notifications) {
			String icon = "bi-bell";
			String badgeClass = "bg-secondary";
			if ("MATCH_FOUND".equals(notif.getType())) {
				icon = "bi-stars";
				badgeClass = "bg-success";
			} else if ("REQUEST_RECEIVED".equals(notif.getType())) {
				icon = "bi-envelope";
				badgeClass = "bg-primary";
			} else if ("REQUEST_ACCEPTED".equals(notif.getType())) {
				icon = "bi-check-circle";
				badgeClass = "bg-success";
			} else if ("NEW_MESSAGE".equals(notif.getType())) {
				icon = "bi-chat";
				badgeClass = "bg-info";
			} else if ("NEW_REVIEW".equals(notif.getType())) {
				icon = "bi-star";
				badgeClass = "bg-warning";
			}
		%>
		<div
			class="list-group-item 
                        <%=notif.isRead() ? "" : "bg-light border-start border-primary border-3"%>
                        mb-2 rounded">
			<div class="d-flex justify-content-between align-items-center">
				<div>
					<span class="badge <%=badgeClass%> me-2"> <i
						class="bi <%=icon%>"></i> <%=notif.getType().replace("_", " ")%>
					</span> <span><%=notif.getContent()%></span>

					<%-- View Match button for MATCH_FOUND --%>
					<%
					if ("MATCH_FOUND".equals(notif.getType()) && notif.getRelatedId() > 0) {
					%>
					<a href="${pageContext.request.contextPath}/exchange/matches"
						class="btn btn-sm btn-success ms-2"> <i
						class="bi bi-arrow-left-right"></i> View Match
					</a>
					<%
					}
					%>

					<%-- View Request button for REQUEST_RECEIVED --%>
					<%
					if ("REQUEST_RECEIVED".equals(notif.getType())) {
					%>
					<a href="${pageContext.request.contextPath}/exchange/matches"
						class="btn btn-sm btn-primary ms-2"> <i
						class="bi bi-check-circle"></i> View Request
					</a>
					<%
					}
					%>
				</div>
				<small class="text-muted ms-3 text-nowrap"> <%=notif.getCreatedAt()%>
				</small>
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