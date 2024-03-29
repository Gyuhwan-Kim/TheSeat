package com.star.seat.menu.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.star.seat.menu.dto.MenuDto;
import com.star.seat.store.dto.StoreDto;

public interface MenuService {
	// 해당 매장의 메뉴 정보를 가져오는 method
	public List<MenuDto> getMenuList(StoreDto sDto);
	
	// 매장 카테고리를 추가하는 method
	public Map<String, Object> addCategory(String email, StoreDto dto);
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	public Map<String, Object> deleteCategory(String email, StoreDto dto);
	
	// 해당 매장의 메뉴 정보를 추가하는 method
	public Map<String, Object> addMenu(MenuDto dto, String email, String realPath);
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	public Map<String, Object> deleteMenu(String email, MenuDto dto);
	
	// 해당 매장의 메뉴를 best로 설정 및 취소하는 method
	public Map<String, Object> bestOnOff(String email, MenuDto dto);
}
