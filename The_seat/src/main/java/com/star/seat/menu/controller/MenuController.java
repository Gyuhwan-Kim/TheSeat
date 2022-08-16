package com.star.seat.menu.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	
	// 임시 메뉴관리 페이지 이동
	@RequestMapping(value = "/store/manageMenu.do", method = RequestMethod.GET)
	public ModelAndView getList(StoreDto sDto, HttpServletRequest request) {

		int num=sDto.getNum();
		String storeName=sDto.getStoreName();
		request.setAttribute("num", num);
		// 해당 매장의 메뉴 정보를 가져오는 method
		service.getMenuList(sDto, request);
		
		// 해당 매장의 정보를 가져오는 method
		sService.getMyStore_num(sDto, request);
		
		ModelAndView mView=new ModelAndView();
		mView.addObject("storeDBNum", sDto.getNum());
		mView.addObject("storeDBName", sDto.getStoreName());

		mView.setViewName("store/manageMenu");
		
		return mView;
	}
	
	// 매장 메뉴 카테고리 추가하는 method
	@RequestMapping(value = "/store/addCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addCategory(StoreDto dto){
		
		service.addCategory(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("beAdded", true);
		
		return map;
	}
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	@RequestMapping(value = "/store/deleteCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCategory(StoreDto dto){
		
		service.deleteCategory(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("beDeleted", true);
		
		return map;
	}
	
	// 해당 매장의 메뉴를 추가하는 method
	@RequestMapping(value = "/store/addMenu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addMenu(@RequestParam int num, MenuDto dto, HttpServletRequest request) {
		
		service.addMenu(num, dto, request);
		
		Map<String, Object> map=new HashMap<>();
		map.put("beAdded", true);
		
		return map;
	}
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	@RequestMapping("/store/deleteMenu.do")
	@ResponseBody
	public Map<String, Object> deleteMenu(MenuDto dto){
		
		service.deleteMenu(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("beDeleted", true);
		
		return map;
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
