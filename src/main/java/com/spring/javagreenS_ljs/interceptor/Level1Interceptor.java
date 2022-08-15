package com.spring.javagreenS_ljs.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level1Interceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? -1 : (int) session.getAttribute("sLevel");
		if(level > 1) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/levelNo");
			dispatcher.forward(request, response);
			return false;
		}
		else if(level == -1) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/NeedLogin");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}
}
