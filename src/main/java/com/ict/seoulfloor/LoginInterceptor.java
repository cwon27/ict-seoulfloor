package com.ict.seoulfloor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	// ��Ʈ�ѷ��� ȣ��Ǳ� ���� �����ϴ� �޼ҵ�
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		// ���� ���� �����ּҰ� �α��� �����϶��� �����Ͽ��� �� ��� �α��� ������ �̵��ϴ� ����� ����
		
		
		String logStatus = (String)request.getSession().getAttribute("logStatus");
		
		if(logStatus == null || !logStatus.equals("Y")) {
			response.sendRedirect(request.getContextPath()+"/user/login");
			return false;
		}
		
		return true;
	}
	
	// ��Ʈ�ѷ��� ���� �� View������ �̵��ϱ����� ����Ǵ� �޼ҵ�
	@Override
	public void postHandle(HttpServletRequest request,
						HttpServletResponse response, Object handler,
						@Nullable ModelAndView mav) throws Exception{
	}
	
	// ��Ʈ�ѷ��� ���� �� ȣ��Ǵ� �޼ҵ�
	@Override
	public void afterCompletion(HttpServletRequest request,
							HttpServletResponse response, Object handler,
							@Nullable Exception e) throws Exception{
		
	}
	
}
