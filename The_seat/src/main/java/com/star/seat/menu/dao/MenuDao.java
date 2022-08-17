package com.star.seat.menu.dao;

import java.util.List;
import java.util.Map;

import com.star.seat.menu.dto.MenuDto;
import com.star.seat.store.dto.StoreDto;

public interface MenuDao {
	
	// 해당 매장의 메뉴 정보를 가져오는 method (사장님)
	public List<MenuDto> getMenuList(StoreDto dto);
	
	// 해당 매장의 메뉴 정보를 가져오는 method (유저)
	public List<MenuDto> getMenuList_num(StoreDto dto);
	
	// 매장 카테고리를 추가하는 method
	// 사실상 update를 이용하는 것
	public int addCategory(StoreDto dto);
	
	// 매장 카테고리를 추가하는 method
	// 사실상 update를 이용하는 것
	public void deleteCategory(StoreDto dto);
	
	// 해당 매장의 메뉴 정보를 추가하는 method
	public void addMenu(MenuDto dto);
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	public void deleteMenu(MenuDto dto);
	
	// 해당 매장의 메뉴를 best로 설정 및 취소하는 method
	public void bestOnOff(MenuDto dto);
	
	// 해당 매장의 베스트 메뉴 수를 가져오는 method
	public int bestCount(StoreDto dto);
	
	// 해당 매장의 메뉴 전체 정보를 삭제하는 method
	public void deleteAllMenu(MenuDto dto);
	
	// 해당 매장의 이름이 변경되면 메뉴 table의 메뉴에서도 storeName을 바꿔주는 method
	public int updateStoreOfMenu(StoreDto dto);
}
