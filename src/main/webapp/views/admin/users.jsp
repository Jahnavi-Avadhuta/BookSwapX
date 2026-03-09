<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<User> users = (List<User>) request.getAttribute("users");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-people"></i> Manage Users
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
				<th>Username</th>
				<th>Email</th>
				<th>Location</th>
				<th>Role</th>
				<th>Trust Score</th>
				<th>Status</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (users != null) {
				for (User u : users) {
			%>
			<tr>
				<td><%=u.getUserId()%></td>
				<td><%=u.getUsername()%></td>
				<td><%=u.getEmail()%></td>
				<td><%=u.getLocation()%></td>
				<td><span
					class="badge <%="ADMIN".equals(u.getRole()) ? "bg-warning text-dark" : "bg-secondary"%>">
						<%=u.getRole()%>
				</span></td>
				<td><%=u.getTrustScore()%></td>
				<td><span
					class="badge <%=u.isActive() ? "bg-success" : "bg-danger"%>">
						<%=u.isActive() ? "Active" : "Blocked"%>
				</span></td>
				<td>
					<form action="${pageContext.request.contextPath}/admin/users"
						method="post" class="d-inline">
						<input type="hidden" name="userId" value="<%=u.getUserId()%>">
						<%
						if (u.isActive()) {
						%>
						<input type="hidden" name="action" value="block">
						<button type="submit" class="btn btn-sm btn-danger"
							onclick="return confirm('Block this user?')">
							<i class="bi bi-slash-circle"></i> Block
						</button>
						<%
						} else {
						%>
						<input type="hidden" name="action" value="unblock">
						<button type="submit" class="btn btn-sm btn-success">
							<i class="bi bi-check-circle"></i> Unblock
						</button>
						<%
						}
						%>
					</form>
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