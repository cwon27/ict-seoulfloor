package com.ict.seoulfloor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	// 컨트롤러가 호출되기 전에 실행하는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		// 현재 접속 매핑주소가 로그인 상태일때만 접속하여야 할 경우 로그인 폼으로 이동하는 기능을 구현
		
		
		String logStatus = (String)request.getSession().getAttribute("logStatus");
		
		if(logStatus == null || !logStatus.equals("Y")) {
			response.sendRedirect(request.getContextPath()+"/user/login");
			return false;
		}
		
		return true;
	}
	
	// 컨트롤러를 실행 후 View페이지 이동하기전에 실행되는 메소드
	@Override
	public void postHandle(HttpServletRequest request,
						HttpServletResponse response, Object handler,
						@Nullable ModelAndView mav) throws Exception{
	}
	
	// 컨트롤러가 실행 후 호출되는 메소드
	@Override
	public void afterCompletion(HttpServletRequest request,
							HttpServletResponse response, Object handler,
							@Nullable Exception e) throws Exception{
		
	}
	
}
