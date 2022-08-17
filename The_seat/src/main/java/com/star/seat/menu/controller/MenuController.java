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
	
	// 메뉴 관리 페이지 이동
	@RequestMapping(value = "/store/manageMenu.do", method = RequestMethod.GET)
	public ModelAndView getList(StoreDto sDto, HttpSession session) {
		// session scope에 있는 email 정보를 받아온다.
		String email = (String)session.getAttribute("email");

		ModelAndView mView=new ModelAndView();
		// email 값과 DB의 매장 번호 data로 해당 매장의 category 정보를 불러온다.
		mView.addObject("categoryList", sService.getMyStore(email, sDto).getCategory());

		// 해당 매장의 메뉴 정보를 가져와서 ModelAndView 객체에 담아줌
		// StoreDto 객체에는 해당 매장 정보가 저장된 DB 번호, 카테고리 정보가 들어있다.
		mView.addObject("menuList", service.getMenuList(email, sDto));
		
		// storeNum data는 요청시 넘겨받은 그대로를 돌려준다.
		mView.addObject("storeNum", sDto.getNum());

		mView.setViewName("store/manageMenu");
		
		return mView;
	}
	
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
	public Map<String, Object> bestOnOff(MenuDto dto, HttpServletRequest request){
		
		boolean beFour=service.bestOnOff(dto, request);
		Map<String, Object> map=new HashMap<>();
		if(beFour) {
			map.put("beSwitched", false);
		} else {
			map.put("beSwitched", true);
		}
		
		return map;
	}
}
