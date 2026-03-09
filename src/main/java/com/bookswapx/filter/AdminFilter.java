package com.bookswapx.filter;

import com.bookswapx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/views/admin/*")
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		HttpSession session = httpRequest.getSession(false);

		if (session != null && session.getAttribute("loggedInUser") != null) {
			User user = (User) session.getAttribute("loggedInUser");
			if ("ADMIN".equals(user.getRole())) {
				chain.doFilter(request, response);
			} else {
				httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/user/dashboard.jsp");
			}
		} else {
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/auth/login.jsp");
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	}
}