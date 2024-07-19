package com.mbc.pwEncoder;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		System.out.println(request.getRequestURL());
		System.out.println(request.getQueryString());
		
		String queryString = request.getQueryString(); 
		
		// url을 서버가 인식할 수 있도록 표준형식으로 변환(쿼리스트링이 있는 경우에는 인식을 못하는 문제를 해결)
		String urlParam = URLEncoder.encode(request.getRequestURL() + "?"+queryString, "utf-8");
		
		if(session.getAttribute("loginDTO") == null) {
			response.sendRedirect(request.getContextPath()+"/member/login.do?moveUrl="+urlParam);
			return false; // 요청 중지
		}
		
		return true;
	}
}
