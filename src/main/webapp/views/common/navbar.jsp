<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%
User navUser = (User) session.getAttribute("loggedInUser");
%>

<nav class="navbar navbar-expand-lg"
	style="background-color: #1C1917; border-bottom: 2px solid #C2410C;">
	<div class="container">

		<!-- LOGO — matches landing page style -->
		<a class="navbar-brand d-flex align-items-center gap-2"
			href="${pageContext.request.contextPath}/user/dashboard"
			style="text-decoration: none;"> <span style="font-size: 1.6rem;">📚</span>
			<span
			style="font-family: 'Playfair Display', Georgia, serif; font-size: 1.4rem; font-weight: 700; color: #1C1917; letter-spacing: 0.5px;">
				BookSwap<span style="color: #C2410C;">X</span>
		</span>
		</a>

		<!-- Mobile toggle -->
		<button class="navbar-toggler border-0" type="button"
			data-bs-toggle="collapse" data-bs-target="#navbarNav"
			style="color: #FAF7F2;">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">

			<!-- Left links — changes based on role -->
			<ul class="navbar-nav me-auto gap-1 mt-2 mt-lg-0">

				<%
				if (navUser != null && "ADMIN".equals(navUser.getRole())) {
				%>
				<!-- ADMIN links only -->
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/admin/dashboard"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 🛡️
						Dashboard </a></li>
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/admin/users"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 👥
						Manage Users </a></li>
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/admin/listings"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 📋
						Manage Listings </a></li>
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/admin/categories"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 🏷️
						Categories </a></li>

				<%
				} else {
				%>
				<!-- REGULAR USER links -->
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/search"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 🔍
						Browse Books </a></li>
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/listing/post"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> ➕ Post
						Listing </a></li>
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/exchange/matches"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 🔄
						Matches </a></li>
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/user/mybooks"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> ❤️
						Wishlist </a></li>
				<%
				}
				%>

			</ul>

			<!-- Right links -->
			<!-- Right links -->
			<ul class="navbar-nav ms-auto align-items-center gap-2 mt-2 mt-lg-0">

				<%
				if (navUser != null && "ADMIN".equals(navUser.getRole())) {
				%>
				<!-- ADMIN right side — only logout -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle d-flex align-items-center gap-2 px-3 py-2 rounded"
					href="#" data-bs-toggle="dropdown"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> <span
						style="background-color: #C2410C; border-radius: 50%; width: 30px; height: 30px; display: inline-flex; align-items: center; justify-content: center; font-size: 0.85rem; font-weight: 700; color: white;">
							<%=navUser.getUsername().substring(0, 1).toUpperCase()%>
					</span> <%=navUser.getUsername()%>
				</a>
					<ul class="dropdown-menu dropdown-menu-end shadow"
						style="background-color: #1C1917; border: 1px solid #C2410C; min-width: 180px;">
						<li><a class="dropdown-item py-2"
							href="${pageContext.request.contextPath}/auth/logout"
							style="color: #ef4444; font-family: 'DM Sans', sans-serif;"
							onmouseover="this.style.backgroundColor='#C2410C';this.style.color='white'"
							onmouseout="this.style.backgroundColor='transparent';this.style.color='#ef4444'">
								🚪 Logout </a></li>
					</ul></li>

				<%
				} else {
				%>
				<!-- REGULAR USER right side -->

				<!-- Messages -->
				<li class="nav-item"><a class="nav-link px-3 py-2 rounded"
					href="${pageContext.request.contextPath}/messages"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 💬
						Messages </a></li>

				<!-- Notifications -->
				<li class="nav-item"><a class="nav-link px-2 py-2 rounded"
					href="${pageContext.request.contextPath}/user/notifications"
					style="color: #FAF7F2; font-size: 1.1rem;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> 🔔 </a></li>

				<!-- User dropdown -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle d-flex align-items-center gap-2 px-3 py-2 rounded"
					href="#" data-bs-toggle="dropdown"
					style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
					onmouseover="this.style.backgroundColor='#C2410C'"
					onmouseout="this.style.backgroundColor='transparent'"> <span
						style="background-color: #C2410C; border-radius: 50%; width: 30px; height: 30px; display: inline-flex; align-items: center; justify-content: center; font-size: 0.85rem; font-weight: 700; color: white;">
							<%=navUser.getUsername().substring(0, 1).toUpperCase()%>
					</span> <%=navUser.getUsername()%>
				</a>
					<ul class="dropdown-menu dropdown-menu-end shadow"
						style="background-color: #1C1917; border: 1px solid #C2410C; min-width: 180px;">
						<li><a class="dropdown-item py-2"
							href="${pageContext.request.contextPath}/user/profile"
							style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
							onmouseover="this.style.backgroundColor='#C2410C'"
							onmouseout="this.style.backgroundColor='transparent'"> 👤
								Profile </a></li>
						<li><a class="dropdown-item py-2"
							href="${pageContext.request.contextPath}/user/mybooks"
							style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
							onmouseover="this.style.backgroundColor='#C2410C'"
							onmouseout="this.style.backgroundColor='transparent'"> 📚 My
								Books </a></li>
						<li><a class="dropdown-item py-2"
							href="${pageContext.request.contextPath}/user/dashboard"
							style="color: #FAF7F2; font-family: 'DM Sans', sans-serif;"
							onmouseover="this.style.backgroundColor='#C2410C'"
							onmouseout="this.style.backgroundColor='transparent'"> 📊
								Dashboard </a></li>
						<li><hr class="dropdown-divider"
								style="border-color: #C2410C; opacity: 0.3;"></li>
						<li><a class="dropdown-item py-2"
							href="${pageContext.request.contextPath}/auth/logout"
							style="color: #ef4444; font-family: 'DM Sans', sans-serif;"
							onmouseover="this.style.backgroundColor='#C2410C';this.style.color='white'"
							onmouseout="this.style.backgroundColor='transparent';this.style.color='#ef4444'">
								🚪 Logout </a></li>
					</ul></li>

				<%
				}
				%>

			</ul>
		</div>
	</div>
</nav>