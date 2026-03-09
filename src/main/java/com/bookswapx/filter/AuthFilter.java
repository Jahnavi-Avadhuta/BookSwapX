package com.bookswapx.filter;

import java.io.IOException;
import com.bookswapx.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession(false);

		boolean isLoggedIn = (session != null && session.getAttribute("loggedInUser") != null);

		String requestURI = httpRequest.getRequestURI();
		String contextPath = httpRequest.getContextPath();

		boolean isPublicPath = requestURI.endsWith("login.jsp") || requestURI.endsWith("register.jsp")
				|| requestURI.endsWith("index.jsp") || requestURI.equals(contextPath + "/")
				|| requestURI.equals(contextPath) || requestURI.contains("/auth/") || requestURI.contains("/css/")
				|| requestURI.contains("/js/") || requestURI.contains("/uploads/");

		if (isLoggedIn) {
			User user = (User) session.getAttribute("loggedInUser");
			if ("ADMIN".equals(user.getRole()) && requestURI.contains("/messages")) {
				httpResponse.sendRedirect(contextPath + "/admin/dashboard");
				return;
			}
			chain.doFilter(request, response);

		} else if (isPublicPath) {
			chain.doFilter(request, response);

		} else {
			httpResponse.sendRedirect(contextPath + "/views/auth/login.jsp");
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	}
}