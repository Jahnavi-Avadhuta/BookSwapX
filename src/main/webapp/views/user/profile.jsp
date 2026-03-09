<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="com.bookswapx.model.Review"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
User user = (User) request.getAttribute("user");
List<Review> reviews = (List<Review>) request.getAttribute("reviews");
double avgRating = request.getAttribute("avgRating") != null ? (double) request.getAttribute("avgRating") : 0.0;
%>

<div class="container mt-4">
	<div class="row">
		<div class="col-md-4">
			<div class="card shadow">
				<div class="card-body text-center">
					<%
					String picPath = "https://via.placeholder.com/100";
					if (user != null && user.getProfilePicture() != null && !user.getProfilePicture().isEmpty()) {
						picPath = request.getContextPath() + "/uploads/profile_pictures/" + user.getProfilePicture();
					}
					%>
					<img src="<%=picPath%>" class="rounded-circle mb-3" width="100"
						height="100" style="object-fit: cover;" alt="Profile Picture">
					<h5><%=user != null ? user.getUsername() : ""%></h5>
					<p class="text-muted">
						<i class="bi bi-geo-alt"></i>
						<%=user != null ? user.getLocation() : ""%>
					</p>
					<span class="badge bg-warning text-dark"> <i
						class="bi bi-star-fill"></i> Trust Score: <%=user != null ? user.getTrustScore() : 0%>
					</span>
					<p class="mt-2">
						<small class="text-muted"> Average Rating: <%=String.format("%.1f", avgRating)%>
							/ 5 (<%=reviews != null ? reviews.size() : 0%> reviews)
						</small>
					</p>
				</div>
			</div>
		</div>

		<div class="col-md-8">
			<div class="card shadow mb-4">
				<div class="card-header bg-dark text-white">
					<h5 class="mb-0">Edit Profile</h5>
				</div>
				<div class="card-body">
					<%
					if ("updated".equals(request.getParameter("success"))) {
					%>
					<div class="alert alert-success">
						<i class="bi bi-check-circle"></i> Profile updated successfully!
					</div>
					<%
					}
					%>
					<%
					if (request.getAttribute("error") != null) {
					%>
					<div class="alert alert-danger">
						<%=request.getAttribute("error")%>
					</div>
					<%
					}
					%>

					<form action="${pageContext.request.contextPath}/user/profile"
						method="post" enctype="multipart/form-data">
						<div class="mb-3">
							<label class="form-label">Profile Picture</label> <input
								type="file" name="profilePicture" class="form-control"
								accept="image/jpeg,image/png,image/jpg"> <small
								class="text-muted">JPG or PNG, max 5MB</small>
						</div>
						<div class="mb-3">
							<label class="form-label">Location</label> <input type="text"
								name="location" class="form-control"
								value="<%=user != null ? user.getLocation() : ""%>" required>
						</div>
						<button type="submit" class="btn btn-dark">
							<i class="bi bi-save"></i> Update Profile
						</button>
					</form>
				</div>
			</div>

			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<h5 class="mb-0">Reviews</h5>
				</div>
				<div class="card-body">
					<%
					if (reviews == null || reviews.isEmpty()) {
					%>
					<p class="text-muted">No reviews yet.</p>
					<%
					} else {
					for (Review review : reviews) {
					%>
					<div class="border-bottom pb-2 mb-2">
						<div class="d-flex justify-content-between">
							<strong>User #<%=review.getReviewerId()%></strong> <span
								class="text-warning"> <%
 for (int i = 0; i < review.getRating(); i++) {
 %>
								<i class="bi bi-star-fill"></i> <%
 }
 %>
							</span>
						</div>
						<p class="mb-0">
							<%=review.getComment() != null ? review.getComment() : ""%>
						</p>
						<small class="text-muted"><%=review.getCreatedAt()%></small>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp"%>