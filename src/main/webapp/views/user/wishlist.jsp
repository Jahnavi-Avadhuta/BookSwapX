<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Wishlist"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<Wishlist> wishlist = (List<Wishlist>) request.getAttribute("wishlist");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-heart"></i> My Wishlist
	</h4>

	<%
	if ("removed".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">Removed from wishlist!</div>
	<%
	}
	%>

	<%
	if (wishlist == null || wishlist.isEmpty()) {
	%>
	<div class="text-center mt-5">
		<i class="bi bi-heart fs-1 text-muted"></i>
		<p class="text-muted mt-3">Your wishlist is empty.</p>
		<a href="${pageContext.request.contextPath}/search"
			class="btn btn-dark"> Browse Books </a>
	</div>
	<%
	} else {
	%>
	<div class="row">
		<%
		for (Wishlist item : wishlist) {
		%>
		<div class="col-md-4 mb-4">
			<div class="card h-100 shadow-sm">
				<div class="card-body">
					<h6 class="card-title fw-bold">
						<%=item.getBookTitle() != null ? item.getBookTitle() : "Unknown Title"%>
					</h6>
					<p class="text-muted small mb-1">
						<i class="bi bi-person"></i>
						<%=item.getBookAuthor() != null ? item.getBookAuthor() : "Unknown Author"%>
					</p>
					<%
					if (item.getBookCondition() != null) {
					%>
					<span class="badge bg-secondary"> <%=item.getBookCondition()%>
					</span>
					<%
					}
					%>
					<%
					if (item.getBookEdition() != null && !item.getBookEdition().isEmpty()) {
					%>
					<p class="text-muted small mt-1 mb-0">
						Edition:
						<%=item.getBookEdition()%>
					</p>
					<%
					}
					%>
					<%
					if (item.getBookIsbn() != null && !item.getBookIsbn().isEmpty()) {
					%>
					<p class="text-muted small mb-0">
						ISBN:
						<%=item.getBookIsbn()%>
					</p>
					<%
					}
					%>
				</div>
				<div class="card-footer d-flex gap-2">
					<a
						href="${pageContext.request.contextPath}/search?keyword=<%= item.getBookTitle() %>"
						class="btn btn-sm btn-dark"> <i class="bi bi-search"></i> Find
						Listings
					</a>
					<form action="${pageContext.request.contextPath}/wishlist"
						method="post" class="d-inline">
						<input type="hidden" name="action" value="remove"> <input
							type="hidden" name="bookId" value="<%=item.getBookId()%>">
						<button type="submit" class="btn btn-sm btn-outline-danger">
							<i class="bi bi-trash"></i> Remove
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
</div>

<%@ include file="../common/footer.jsp"%>