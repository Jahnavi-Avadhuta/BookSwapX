<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.PotentialMatch"%>
<%@ page import="com.bookswapx.model.ExchangeRequest"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
List<PotentialMatch> matches = (List<PotentialMatch>) request.getAttribute("matches");
User currentUser = (User) session.getAttribute("loggedInUser");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-arrow-left-right"></i> My Matches
	</h4>
	<p class="text-muted">Potential book exchanges found for you!</p>

	<%
	if ("requested".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">Exchange request sent!</div>
	<%
	}
	%>
	<%
	if ("accepted".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-success">Exchange accepted! Check your
		transactions.</div>
	<%
	}
	%>
	<%
	if ("rejected".equals(request.getParameter("success"))) {
	%>
	<div class="alert alert-warning">Exchange rejected.</div>
	<%
	}
	%>

	<%
	if (matches == null || matches.isEmpty()) {
	%>
	<div class="text-center mt-5">
		<i class="bi bi-search fs-1 text-muted"></i>
		<p class="text-muted mt-3">No matches found yet. Post more
			listings to find matches!</p>
		<a href="${pageContext.request.contextPath}/listing/post"
			class="btn btn-dark"> Post a Listing </a>
	</div>
	<%
	} else {
	%>
	<div class="row">
		<%
		for (PotentialMatch match : matches) {
			boolean isUserA = match.getUserAId() == currentUser.getUserId();
			String giveTitle = isUserA ? match.getBookATitle() : match.getBookBTitle();
			String giveAuthor = isUserA ? match.getBookAAuthor() : match.getBookBAuthor();
			String getTitle = isUserA ? match.getBookBTitle() : match.getBookATitle();
			String getAuthor = isUserA ? match.getBookBAuthor() : match.getBookAAuthor();
			String otherUserName = isUserA ? match.getUserBName() : match.getUserAName();
			int otherUserId = isUserA ? match.getUserBId() : match.getUserAId();
		%>
		<div class="col-md-6 mb-4">
			<div class="card border-success shadow">
				<div class="card-header bg-success text-white">
					<i class="bi bi-stars"></i> Perfect Match Found! <span
						class="badge bg-light text-dark float-end"> <%=match.getStatus()%>
					</span>
				</div>
				<div class="card-body">
					<p class="text-center mb-3">
						<i class="bi bi-person-circle"></i> <strong>Match with: <%=otherUserName%></strong>
						<a
							href="${pageContext.request.contextPath}/messages?with=<%= otherUserId %>"
							class="btn btn-sm btn-outline-dark ms-2"> <i
							class="bi bi-chat"></i> Message
						</a>
					</p>

					<div class="row text-center">
						<div class="col">
							<div class="card bg-light">
								<div class="card-body p-2">
									<i class="bi bi-book fs-2 text-primary"></i>
									<p class="mt-1 mb-0 fw-bold">
										<%=giveTitle%>
									</p>
									<small class="text-muted"> <%=giveAuthor != null ? giveAuthor : ""%>
									</small> <br> <small class="text-danger fw-bold"> You Give
									</small>
								</div>
							</div>
						</div>
						<div class="col-auto align-self-center">
							<i class="bi bi-arrow-left-right fs-3 text-success"></i>
						</div>
						<div class="col">
							<div class="card bg-light">
								<div class="card-body p-2">
									<i class="bi bi-book fs-2 text-warning"></i>
									<p class="mt-1 mb-0 fw-bold">
										<%=getTitle%>
									</p>
									<small class="text-muted"> <%=getAuthor != null ? getAuthor : ""%>
									</small> <br> <small class="text-success fw-bold"> You Get
									</small>
								</div>
							</div>
						</div>
					</div>

					<p class="text-center mt-3 mb-0">
						<span class="badge bg-success fs-6"> <i
							class="bi bi-currency-dollar"></i> Cost: FREE Exchange!
						</span>
					</p>
				</div>
				<div class="card-footer">
					<%
					ExchangeRequest existingRequest = null;
					try {
						com.bookswapx.dao.ExchangeDAO exDao = new com.bookswapx.dao.ExchangeDAO();
						existingRequest = exDao.getRequestByMatchId(match.getMatchId());
					} catch (Exception ex) {
						ex.printStackTrace();
					}

					boolean iAmRequester = existingRequest != null && existingRequest.getRequesterId() == currentUser.getUserId();
					boolean requestExists = existingRequest != null && "PENDING".equals(existingRequest.getStatus());
					%>

					<%
					if (existingRequest == null) {
					%>
					<%-- No request yet — anyone can send --%>
					<form action="${pageContext.request.contextPath}/exchange/request"
						method="post">
						<input type="hidden" name="matchId"
							value="<%=match.getMatchId()%>"> <input type="hidden"
							name="action" value="REQUEST">
						<button type="submit" class="btn btn-success w-100">
							<i class="bi bi-check-circle"></i> Send Exchange Request
						</button>
					</form>

					<%
					} else if (iAmRequester) {
					%>
					<%-- I sent the request — waiting for other user --%>
					<div class="alert alert-info mb-0 text-center">
						<i class="bi bi-hourglass-split"></i> Request sent! Waiting for
						<%=otherUserName%>
						to respond.
					</div>

					<%
					} else {
					%>
					<%-- Other user sent request — I can Accept or Reject --%>
					<p class="text-center mb-2">
						<strong><%=otherUserName%></strong> wants to exchange with you!
					</p>
					<div class="d-flex gap-2">
						<form action="${pageContext.request.contextPath}/exchange/request"
							method="post" class="w-50">
							<input type="hidden" name="matchId"
								value="<%=match.getMatchId()%>"> <input type="hidden"
								name="action" value="ACCEPT">
							<button type="submit" class="btn btn-success w-100">
								<i class="bi bi-check-circle"></i> Accept
							</button>
						</form>
						<form action="${pageContext.request.contextPath}/exchange/request"
							method="post" class="w-50">
							<input type="hidden" name="matchId"
								value="<%=match.getMatchId()%>"> <input type="hidden"
								name="action" value="REJECT">
							<button type="submit" class="btn btn-danger w-100">
								<i class="bi bi-x-circle"></i> Reject
							</button>
						</form>
					</div>
					<%
					}
					%>
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