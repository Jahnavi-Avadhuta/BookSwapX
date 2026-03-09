<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
User reviewedUser = (User) request.getAttribute("reviewedUser");
String transactionId = (String) request.getAttribute("transactionId");
%>

<div class="container mt-4">
	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<h5 class="mb-0">
						<i class="bi bi-star"></i> Review
						<%=reviewedUser != null ? reviewedUser.getUsername() : "User"%>
					</h5>
				</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/review/add"
						method="post">
						<input type="hidden" name="reviewedUserId"
							value="<%=reviewedUser != null ? reviewedUser.getUserId() : ""%>">
						<input type="hidden" name="transactionId"
							value="<%=transactionId != null ? transactionId : ""%>">

						<div class="mb-3">
							<label class="form-label fw-bold"> Rating (1-5 stars) </label>
							<div class="d-flex gap-3">
								<%
								for (int i = 1; i <= 5; i++) {
								%>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="rating"
										id="star<%=i%>" value="<%=i%>" required> <label
										class="form-check-label" for="star<%=i%>"> <%=i%> <i
										class="bi bi-star-fill text-warning"></i>
									</label>
								</div>
								<%
								}
								%>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label fw-bold"> Comment (optional) </label>
							<textarea name="comment" class="form-control" rows="3"
								placeholder="Share your experience...">
                            </textarea>
						</div>

						<div class="d-flex gap-2">
							<button type="submit" class="btn btn-warning">
								<i class="bi bi-star-fill"></i> Submit Review
							</button>
							<a href="${pageContext.request.contextPath}/user/transactions"
								class="btn btn-outline-secondary"> Cancel </a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp"%>