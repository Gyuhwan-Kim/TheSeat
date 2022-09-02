package com.star.seat.filter;

import java.io.IOException;
import java.net.URLDecoder;
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
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/users/info", "/store/manage/*"})
public class LoginFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	// Filter의 동작 부분
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// ServletRequest 객체를 HttpServletRequest 객체로 casting
		HttpServletRequest req = (HttpServletRequest)request;
		HttpSession session = req.getSession();
		// HttpSession 객체에 'email' 이라는 key로 value가 있는지 check
		String email = (String)session.getAttribute("email");
		
		// 있다면 그대로 원래 하던 일 진행
		if(email != null) {
			chain.doFilter(request, response);
		// 아니라면 동작할 부분
		} else {
			// 강제로 redirect 된 것이라면 기존에 있던 자리로 돌아가야 함.
			// 기존 요청 경로 uri
			String url = req.getRequestURL().toString();

			// 기존 요청 경로 uri query
			String query = req.getQueryString();

			String encodedUrl = null;
			if(query != null) {
				encodedUrl = URLEncoder.encode(url + "?" + query);
			}
			
			// redirect
			HttpServletResponse resp = (HttpServletResponse)response;
			String contextPath = req.getContextPath();
			resp.sendRedirect(contextPath + "/users/loginform.do?redirect=" + encodedUrl);
		}
	}

	@Override
	public void destroy() {
		
	}

}
