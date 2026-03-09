<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.Report"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
int totalUsers = request.getAttribute("totalUsers") != null ? (int) request.getAttribute("totalUsers") : 0;
int activeListings = request.getAttribute("activeListings") != null ? (int) request.getAttribute("activeListings") : 0;
int pendingReports = request.getAttribute("pendingReports") != null ? (int) request.getAttribute("pendingReports") : 0;
List<Report> pendingReportsList = (List<Report>) request.getAttribute("pendingReportsList");
%>

<style>
.bsx-admin-stat {
	border-radius: 14px;
	padding: 2rem 1.75rem;
	position: relative;
	overflow: hidden;
	border: none;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .12);
	transition: transform .25s, box-shadow .25s;
	color: #fff;
}

.bsx-admin-stat:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 32px rgba(0, 0, 0, .18);
}

.bsx-admin-stat .s-num {
	font-family: 'Playfair Display', 'Georgia', serif;
	font-size: 3.25rem;
	font-weight: 900;
	line-height: 1;
	color: #fff !important;
	display: block;
	margin-bottom: .3rem;
}

.bsx-admin-stat .s-lbl {
	font-size: .8rem;
	font-weight: 700;
	letter-spacing: .1em;
	text-transform: uppercase;
	color: rgba(255, 255, 255, .75) !important;
	display: block;
}

.bsx-admin-stat .s-bg {
	position: absolute;
	right: 1rem;
	bottom: .5rem;
	font-size: 5rem;
	opacity: .1;
	line-height: 1;
	pointer-events: none;
}

.stat-users {
	background: linear-gradient(135deg, #1C1917 0%, #3D3532 100%);
}

.stat-listings {
	background: linear-gradient(135deg, #4A7C59 0%, #6DAF80 100%);
}

.stat-reports {
	background: linear-gradient(135deg, #C2410C 0%, #EA580C 100%);
}

.admin-page-title {
	font-family: 'Playfair Display', Georgia, serif;
	font-size: 1.85rem;
	font-weight: 700;
	color: #1C1917;
	display: flex;
	align-items: center;
	gap: .6rem;
	margin-bottom: 1.75rem;
}

.admin-page-title i {
	color: #C2410C;
	font-size: 1.5rem;
}

.admin-action-btn {
	display: inline-flex;
	align-items: center;
	gap: .4rem;
	padding: .55rem 1.15rem;
	border-radius: 8px;
	font-size: .875rem;
	font-weight: 600;
	text-decoration: none;
	transition: all .2s;
	border: 2px solid transparent;
}

.aab-dark {
	background: #1C1917;
	color: #fff;
	border-color: #1C1917;
}

.aab-dark:hover {
	background: #C2410C;
	border-color: #C2410C;
	color: #fff;
	transform: translateY(-1px);
}

.aab-outline {
	background: transparent;
	color: #1C1917;
	border-color: #D6CFC5;
}

.aab-outline:hover {
	border-color: #C2410C;
	color: #C2410C;
	background: rgba(194, 65, 12, .04);
}

/* Section title */
.admin-section-title {
	font-family: 'Playfair Display', Georgia, serif;
	font-size: 1.2rem;
	font-weight: 700;
	color: #1C1917;
	margin-bottom: 1rem;
	padding-bottom: .6rem;
	border-bottom: 2px solid #F0EBE1;
}

.bsx-table-wrap {
	border: 1.5px solid #D6CFC5;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 2px 8px rgba(28, 25, 23, .06);
}
</style>

<div class="container mt-4 pb-5">

	<h2 class="admin-page-title">
		<i class="bi bi-shield-lock-fill"></i> Admin Dashboard
	</h2>

	<div class="row g-3 mb-4">

		<div class="col-md-4">
			<div class="bsx-admin-stat stat-users">
				<span class="s-num"><%=totalUsers%></span> <span class="s-lbl">Total
					Users</span> <span class="s-bg">👥</span>
			</div>
		</div>

		<div class="col-md-4">
			<div class="bsx-admin-stat stat-listings">
				<span class="s-num"><%=activeListings%></span> <span class="s-lbl">Active
					Listings</span> <span class="s-bg">📚</span>
			</div>
		</div>

		<div class="col-md-4">
			<div class="bsx-admin-stat stat-reports">
				<span class="s-num"><%=pendingReports%></span> <span class="s-lbl">Pending
					Reports</span> <span class="s-bg">🚩</span>
			</div>
		</div>

	</div>

	<div class="mb-4 d-flex flex-wrap gap-2">
		<a href="${pageContext.request.contextPath}/admin/users"
			class="admin-action-btn aab-dark"> <i class="bi bi-people-fill"></i>
			Manage Users
		</a> <a href="${pageContext.request.contextPath}/admin/listings"
			class="admin-action-btn aab-outline"> <i class="bi bi-list-ul"></i>
			Manage Listings
		</a> <a href="${pageContext.request.contextPath}/admin/categories"
			class="admin-action-btn aab-outline"> <i class="bi bi-tags-fill"></i>
			Manage Categories
		</a>
	</div>

	<h5 class="admin-section-title">
		<i class="bi bi-flag-fill text-danger me-2"></i>Pending Reports
	</h5>

	<%
	if (pendingReportsList == null || pendingReportsList.isEmpty()) {
	%>
	<div
		style="padding: 2.5rem; text-align: center; background: #fff; border: 1.5px solid #D6CFC5; border-radius: 12px;">
		<span
			style="font-size: 2.5rem; opacity: .25; display: block; margin-bottom: .75rem;">🚩</span>
		<p style="color: #78716C; margin: 0; font-size: .9rem;">No pending
			reports. The community is clean!</p>
	</div>
	<%
	} else {
	%>
	<div class="bsx-table-wrap">
		<table class="table table-hover mb-0">
			<thead>
				<tr>
					<th>Report ID</th>
					<th>Reporter</th>
					<th>Reason</th>
					<th>Description</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Report report : pendingReportsList) {
				%>
				<tr>
					<td><span style="font-family: monospace; color: #78716C;">#<%=report.getReportId()%></span></td>
					<td>User #<%=report.getReporterId()%></td>
					<td><span class="badge bg-danger"><%=report.getReason()%></span></td>
					<td><%=report.getDescription()%></td>
					<td style="font-size: .8rem; color: #78716C;"><%=report.getCreatedAt()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<%
	}
	%>

</div>

<%@ include file="../common/footer.jsp"%>
