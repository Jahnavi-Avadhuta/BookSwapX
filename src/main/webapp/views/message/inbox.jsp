<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.bookswapx.model.User, com.bookswapx.model.Message, java.util.List"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/navbar.jsp"%>

<%
User msgUser = (User) session.getAttribute("loggedInUser");
User receiver = (User) request.getAttribute("receiver");
List<Message> conversation = (List<Message>) request.getAttribute("conversation");
List<User> conversations = (List<User>) request.getAttribute("conversations");
%>

<div class="container mt-4">
	<h4 class="mb-4">💬 Messages</h4>

	<div class="row" style="height: 600px;">

		<div class="col-md-4">
			<div class="card h-100 shadow-sm">
				<div class="card-header"
					style="background-color: #1C1917; color: #FAF7F2;">
					<strong>Conversations</strong>
				</div>
				<div class="card-body p-0" style="overflow-y: auto;">
					<%
					if (conversations == null || conversations.isEmpty()) {
					%>
					<div class="text-center p-4 text-muted">
						<p>No conversations yet.</p>
						<a href="${pageContext.request.contextPath}/search"
							class="btn btn-sm btn-dark"> Browse Books </a>
					</div>
					<%
					} else {
					for (User conv : conversations) {
						boolean isActive = receiver != null && receiver.getUserId() == conv.getUserId();
					%>
					<a
						href="${pageContext.request.contextPath}/messages?with=<%= conv.getUserId() %>"
						class="d-flex align-items-center gap-3 p-3 text-decoration-none border-bottom"
						style="background-color: <%= isActive ? "#FAF7F2" : "white" %>;
                                  color: #1C1917;"
						onmouseover="this.style.backgroundColor='#FAF7F2'"
						onmouseout="this.style.backgroundColor='<%= isActive ? "#FAF7F2" : "white" %>'">

						<div
							style="width: 42px; height: 42px; border-radius: 50%; background-color: #C2410C; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 1rem; flex-shrink: 0;">
							<%=conv.getUsername().substring(0, 1).toUpperCase()%>
						</div>

						<div>
							<div
								style="font-weight: 600; font-family: 'DM Sans', sans-serif;">
								<%=conv.getUsername()%>
							</div>
							<div style="font-size: 0.8rem; color: #6B7280;">
								<%=conv.getLocation()%>
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
			<div class="card h-100 shadow-sm">

				<%
				if (receiver == null) {
				%>
				<div
					class="card-body d-flex flex-column
                            align-items-center justify-content-center text-muted">
					<div style="font-size: 3rem;">💬</div>
					<p class="mt-3">Select a conversation to start chatting</p>
				</div>

				<%
				} else {
				%>
				<div class="card-header d-flex align-items-center gap-3"
					style="background-color: #1C1917; color: #FAF7F2;">
					<div
						style="width: 36px; height: 36px; border-radius: 50%; background-color: #C2410C; display: flex; align-items: center; justify-content: center; font-weight: 700;">
						<%=receiver.getUsername().substring(0, 1).toUpperCase()%>
					</div>
					<div>
						<strong><%=receiver.getUsername()%></strong>
						<div style="font-size: 0.8rem; color: #9CA3AF;">
							<%=receiver.getLocation()%>
						</div>
					</div>
				</div>

				<div class="card-body p-3" style="overflow-y: auto; flex: 1;"
					id="chatBox">
					<%
					if (conversation == null || conversation.isEmpty()) {
					%>
					<div class="text-center text-muted mt-5">No messages yet. Say
						hello! 👋</div>
					<%
					} else {
					for (Message msg : conversation) {
						boolean isSender = msg.getSenderId() == msgUser.getUserId();
					%>
					<div
						class="d-flex <%=isSender ? "justify-content-end" : "justify-content-start"%>
                            mb-2">
						<div class="px-3 py-2 rounded-3"
							style="max-width: 70%;
                                        background-color: <%=isSender ? "#1C1917" : "#F3F4F6"%>;
                                        color: <%=isSender ? "#FAF7F2" : "#1C1917"%>;">
							<%=msg.getMessage()%>
							<div
								style="font-size: 0.7rem; opacity: 0.6; margin-top: 4px; text-align: right;">
								<%=msg.getSentAt()%>
							</div>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>

				<div class="card-footer p-3"
					style="background-color: #F9FAFB; border-top: 1px solid #E5E7EB;">
					<form action="${pageContext.request.contextPath}/messages"
						method="post">
						<input type="hidden" name="receiverId"
							value="<%=receiver.getUserId()%>">
						<div class="d-flex gap-2">
							<input type="text" name="message" class="form-control"
								placeholder="Type a message..." autocomplete="off" required
								style="border: 1px solid #D1D5DB; border-radius: 20px; padding: 10px 16px;">
							<button type="submit" class="btn px-4"
								style="background-color: #C2410C; color: white; border-radius: 20px;">
								Send ➤</button>
						</div>
					</form>
				</div>
				<%
				}
				%>

			</div>
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