package com.star.seat;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	/*
	 *  "/home.do" 요청이 왔을때 이 메소드로 요청으로 처리하기 
	 *  
	 *  .do 는 생략 가능 
	 */
	@RequestMapping("/home")
	public String home() {
		//view 페이지 (jsp페이지) 로 forward 이동해서 응답 
		return "home";
	}
}




