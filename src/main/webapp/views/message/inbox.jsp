<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookswapx.model.User"%>
<%@ page import="com.bookswapx.model.Message"%>
<%@ page import="java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
User msgUser = (User) session.getAttribute("loggedInUser");
User receiver = (User) request.getAttribute("receiver");
List<Message> conversation = (List<Message>) request.getAttribute("conversation");
List<User> conversationUsers = (List<User>) request.getAttribute("conversationUsers");
%>

<div class="container mt-4">
	<h4>
		<i class="bi bi-chat-dots"></i> Messages
	</h4>

	<div class="row">
		<div class="col-md-4">
			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<h6 class="mb-0">Conversations</h6>
				</div>
				<div class="card-body p-0">
					<%
					if (conversationUsers == null || conversationUsers.isEmpty()) {
					%>
					<p class="text-muted text-center p-3">No conversations yet.</p>
					<%
					} else {
					for (User convUser : conversationUsers) {
						boolean isActive = receiver != null && receiver.getUserId() == convUser.getUserId();
					%>
					<a
						href="${pageContext.request.contextPath}/messages?with=<%= convUser.getUserId() %>"
						class="list-group-item list-group-item-action
                           <%= isActive ? "active" : "" %>">
						<div class="d-flex align-items-center">
							<i class="bi bi-person-circle fs-4 me-2"></i>
							<div>
								<strong><%=convUser.getUsername()%></strong> <br> <small
									class="<%=isActive ? "text-white" : "text-muted"%>">
									<i class="bi bi-geo-alt"></i> <%=convUser.getLocation()%>
								</small>
							</div>
						</div>
					</a>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>

		<div class="col-md-8">
			<%
			if (receiver != null) {
			%>
			<div class="card shadow">
				<div class="card-header bg-dark text-white">
					<i class="bi bi-person-circle"></i> Conversation with
					<%=receiver.getUsername()%>
					<small class="float-end"> <i class="bi bi-geo-alt"></i> <%=receiver.getLocation()%>
					</small>
				</div>
				<div class="card-body" style="height: 400px; overflow-y: auto;"
					id="chatBox">
					<%
					if (conversation == null || conversation.isEmpty()) {
					%>
					<p class="text-muted text-center mt-3">No messages yet. Start
						the conversation!</p>
					<%
					} else {
					for (Message msg : conversation) {
						boolean isSender = msg.getSenderId() == msgUser.getUserId();
					%>
					<div
						class="d-flex <%=isSender ? "justify-content-end" : "justify-content-start"%> mb-2">
						<div
							class="p-2 rounded <%=isSender ? "bg-dark text-white" : "bg-light border"%>"
							style="max-width: 70%">
							<%=msg.getMessage()%>
							<br> <small class="opacity-75"> <%=msg.getSentAt()%>
							</small>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>
				<div class="card-footer">
					<form action="${pageContext.request.contextPath}/messages"
						method="post">
						<input type="hidden" name="receiverId"
							value="<%=receiver.getUserId()%>">
						<div class="input-group">
							<input type="text" name="message" class="form-control"
								placeholder="Type a message..." required>
							<button type="submit" class="btn btn-dark">
								<i class="bi bi-send"></i> Send
							</button>
						</div>
					</form>
				</div>
			</div>
			<%
			} else {
			%>
			<div class="card shadow">
				<div class="card-body text-center mt-3">
					<i class="bi bi-chat-square fs-1 text-muted"></i>
					<p class="text-muted mt-3">Select a conversation from the left
						to start messaging.</p>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
</div>

<script>
	window.onload = function() {
		var chatBox = document.getElementById('chatBox');
		if (chatBox)
			chatBox.scrollTop = chatBox.scrollHeight;
	}
</script>

<%@ include file="../common/footer.jsp"%>