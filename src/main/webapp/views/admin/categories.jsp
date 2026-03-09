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
	<div class="row">
		<div class="col-md-5">
			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<h5 class="mb-0">
						<i class="bi bi-tags"></i> Add Category
					</h5>
				</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/admin/categories"
						method="post">
						<input type="hidden" name="action" value="add">
						<div class="mb-3">
							<label class="form-label">Category Name</label> <input
								type="text" name="categoryName" class="form-control"
								placeholder="e.g. AI/ML, Civil Engineering" required>
						</div>
						<button type="submit" class="btn btn-dark w-100">
							<i class="bi bi-plus-circle"></i> Add Category
						</button>
					</form>
				</div>
			</div>
		</div>

		<div class="col-md-7">
			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<h5 class="mb-0">Existing Categories</h5>
				</div>
				<div class="card-body">
					<%
					if (categories == null || categories.isEmpty()) {
					%>
					<p class="text-muted">No categories found.</p>
					<%
					} else {
					%>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Category cat : categories) {
							%>
							<tr>
								<td><%=cat.getCategoryId()%></td>
								<td><%=cat.getCategoryName()%></td>
								<td>
									<form
										action="${pageContext.request.contextPath}/admin/categories"
										method="post">
										<input type="hidden" name="action" value="delete"> <input
											type="hidden" name="categoryId"
											value="<%=cat.getCategoryId()%>">
										<button type="submit" class="btn btn-sm btn-danger"
											onclick="return confirm('Delete category?')">
											<i class="bi bi-trash"></i>
										</button>
									</form>
								</td>
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
	</div>
</div>

<%@ include file="../common/footer.jsp"%>