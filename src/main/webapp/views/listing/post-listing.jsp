<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Category"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<div class="container mt-4">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<h5 class="mb-0">
						<i class="bi bi-plus-circle"></i> Post a Listing
					</h5>
				</div>
				<div class="card-body">
					<%
					if (request.getAttribute("error") != null) {
					%>
					<div class="alert alert-danger"><%=request.getAttribute("error")%></div>
					<%
					}
					%>

					<form action="${pageContext.request.contextPath}/listing/post"
						method="post">
						<h6 class="fw-bold mb-3">Book Details</h6>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label">Book Title *</label> <input
									type="text" name="title" class="form-control"
									placeholder="e.g. Data Structures" required>
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label">Author</label> <input type="text"
									name="author" class="form-control"
									placeholder="e.g. Narasimha Karumanchi">
							</div>
						</div>
						<div class="row">
							<div class="col-md-4 mb-3">
								<label class="form-label">Category *</label> <select
									name="categoryId" class="form-select" required>
									<option value="">Select Category</option>
									<%
									if (categories != null) {
										for (Category cat : categories) {
									%>
									<option value="<%=cat.getCategoryId()%>">
										<%=cat.getCategoryName()%>
									</option>
									<%
									}
									}
									%>
								</select>
							</div>
							<div class="col-md-4 mb-3">
								<label class="form-label">Condition *</label> <select
									name="bookCondition" class="form-select" required>
									<option value="NEW">New</option>
									<option value="GOOD">Good</option>
									<option value="OLD">Old</option>
								</select>
							</div>
							<div class="col-md-4 mb-3">
								<label class="form-label">Edition</label> <input type="text"
									name="edition" class="form-control"
									placeholder="e.g. 3rd Edition">
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label">ISBN</label> <input type="text"
									name="isbn" class="form-control" placeholder="Optional">
							</div>
						</div>

						<hr>
						<h6 class="fw-bold mb-3">Listing Details</h6>
						<div class="row">
							<div class="col-md-4 mb-3">
								<label class="form-label">Listing Type *</label> <select
									name="type" class="form-select" required
									onchange="togglePrice(this.value)">
									<option value="SELL">Sell</option>
									<option value="BUY">Buy / Looking For</option>
								</select>
							</div>
							<div class="col-md-4 mb-3" id="priceField">
								<label class="form-label">Price (₹)</label> <input type="number"
									name="price" class="form-control" placeholder="0.00"
									step="0.01" min="0" value="0">
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">Description</label>
							<textarea name="description" class="form-control" rows="3"
								placeholder="Describe the book condition..."></textarea>
						</div>
						<div class="mb-3">
							<label class="form-label">Preferred Meeting Location</label> <input
								type="text" name="meetingLocation" class="form-control"
								placeholder="e.g. College Gate, Library">
						</div>
						<button type="submit" class="btn btn-dark w-100">
							<i class="bi bi-send"></i> Post Listing
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	function togglePrice(type) {
		document.getElementById('priceField').style.display = type === 'BUY' ? 'none'
				: 'block';
	}
</script>

<%@ include file="../common/footer.jsp"%>