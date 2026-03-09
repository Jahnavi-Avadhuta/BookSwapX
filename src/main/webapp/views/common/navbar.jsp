<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%
User navUser = (User) session.getAttribute("loggedInUser");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container">
		<a class="navbar-brand fw-bold"
			href="${pageContext.request.contextPath}/user/dashboard"> <i
			class="bi bi-book-half"></i> BookSwapX
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto">

				<%-- Browse Books — everyone sees this --%>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/search"> <i
						class="bi bi-search"></i> Browse Books
				</a></li>

				<%-- Post Listing, Matches, Wishlist — users only --%>
				<%
				if (navUser != null && "USER".equals(navUser.getRole())) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/listing/post"> <i
						class="bi bi-plus-circle"></i> Post Listing
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/exchange/matches"> <i
						class="bi bi-arrow-left-right"></i> Matches
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/wishlist"> <i
						class="bi bi-heart"></i> Wishlist
				</a></li>
				<%
				}
				%>

				<%-- Admin link — admin only --%>
				<%
				if (navUser != null && "ADMIN".equals(navUser.getRole())) {
				%>
				<li class="nav-item"><a class="nav-link text-warning fw-bold"
					href="${pageContext.request.contextPath}/views/admin/dashboard.jsp">
						<i class="bi bi-shield-check"></i> Admin
				</a></li>
				<%
				}
				%>

			</ul>

			<ul class="navbar-nav ms-auto">

				<%-- Messages — users only --%>
				<%
				if (navUser != null && "USER".equals(navUser.getRole())) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/messages"> <i
						class="bi bi-chat-dots"></i> Messages <%
 if (session.getAttribute("unreadMessages") != null
 		&& ((Number) session.getAttribute("unreadMessages")).intValue() > 0) {
 %> <span class="badge bg-danger"> <%=session.getAttribute("unreadMessages")%>
					</span> <%
 }
 %>
				</a></li>
				<%
				}
				%>

				<%-- Notifications bell — everyone --%>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/notifications"> <i
						class="bi bi-bell"></i> <%
 if (session.getAttribute("unreadNotifications") != null
 		&& ((Number) session.getAttribute("unreadNotifications")).intValue() > 0) {
 %> <span class="badge bg-danger"> <%=session.getAttribute("unreadNotifications")%>
					</span> <%
 }
 %>
				</a></li>

				<%-- User dropdown --%>
				<%
				if (navUser != null) {
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
						<i class="bi bi-person-circle"></i> <%=navUser.getUsername()%>
				</a>
					<ul class="dropdown-menu dropdown-menu-end">
						<%
						if ("USER".equals(navUser.getRole())) {
						%>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/user/profile"> <i
								class="bi bi-person"></i> Profile
						</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/user/dashboard"> <i
								class="bi bi-speedometer2"></i> Dashboard
						</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/user/mybooks"> <i
								class="bi bi-book"></i> My Books
						</a></li>

						<%-- ADD TRANSACTIONS LINK HERE --%>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/user/transactions">
								<i class="bi bi-clock-history"></i> Transactions
						</a></li>

						<%
						} else if ("ADMIN".equals(navUser.getRole())) {
						%>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/admin/dashboard"> <i
								class="bi bi-speedometer2"></i> Admin Dashboard
						</a></li>
						<%
						}
						%>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item text-danger"
							href="${pageContext.request.contextPath}/auth/logout"> <i
								class="bi bi-box-arrow-right"></i> Logout
						</a></li>
					</ul></li>
				<%
				}
				%>

			</ul>
		</div>
	</div>
</nav>