package com.star.seat.filter;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {"/users/*", "/store/*", "/order/*"})
public class AddressBarFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		String urlRequest = req.getHeader("referer");
		if(urlRequest != null) {
			chain.doFilter(request, response);
		} else {
			// error page로 강제 redirect
			HttpServletResponse resp = (HttpServletResponse)response;
			String contextPath = req.getContextPath();
			resp.sendRedirect(contextPath + "/error/requestBan.do");
		}
	}

	@Override
	public void destroy() {
		
	}

}
