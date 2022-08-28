package com.star.seat.menu.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.menu.dto.MenuDto;
import com.star.seat.menu.service.MenuService;
import com.star.seat.store.dto.StoreDto;
import com.star.seat.store.service.StoreService;

@Controller
public class MenuController {
	@Autowired
	private MenuService service;
	@Autowired
	private StoreService sService;
	
	// 매장 메뉴 카테고리 추가하는 method
	@RequestMapping(value = "/store/addCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addCategory(StoreDto dto, HttpSession session){
		String email = (String)session.getAttribute("email");
		
		return service.addCategory(email, dto);
	}
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	@RequestMapping(value = "/store/deleteCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCategory(StoreDto dto, HttpSession session){
		String email = (String)session.getAttribute("email");
		
		return service.deleteCategory(email, dto);
	}
	
	// 해당 매장의 메뉴를 추가하는 method
	@RequestMapping(value = "/store/addMenu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addMenu(MenuDto dto, HttpServletRequest request) {
		String email = (String)request.getSession().getAttribute("email");
		String realPath = request.getServletContext().getRealPath("/upload");
		
		return service.addMenu(dto, email, realPath);
	}
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	@RequestMapping("/store/deleteMenu.do")
	@ResponseBody
	public Map<String, Object> deleteMenu(MenuDto dto, HttpSession session){
		String email = (String)session.getAttribute("email");
		
		return service.deleteMenu(email, dto);
	}
	
	// 해당 매장의 메뉴를 best로 설정 및 취소하는 method
	@RequestMapping(value = "/store/bestOnOff.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> bestOnOff(MenuDto dto, HttpSession session){
		String email = (String)session.getAttribute("email");

		return service.bestOnOff(email, dto);
	}
}
