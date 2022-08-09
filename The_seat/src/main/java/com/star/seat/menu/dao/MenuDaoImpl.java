package com.star.seat.menu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.star.seat.menu.dto.MenuDto;
import com.star.seat.store.dto.StoreDto;

@Repository
public class MenuDaoImpl implements MenuDao{
	@Autowired
	private SqlSession session;
	
	// 해당 매장의 메뉴 정보를 추가하는 method
	@Override
	public void addMenu(MenuDto dto) {
		session.insert("addMenu", dto);
	}
	/*
	// 해당 매장의 메뉴 정보를 가져오는 method (사장님)
	@Override
	public List<MenuDto> getMenuList(StoreDto dto) {
		
		return session.selectList("getMenuList", dto);
	}
	*/
	@Override
	public List<MenuDto> getMenuList(Map<String, Object> map) {
		
		return session.selectList("getMenuList", map);
	}
	@Override
	public List<MenuDto> getMenuList2(StoreDto dto) {

		return session.selectList("getMenuList2", dto);
	}
	
	// 해당 매장의 메뉴 정보를 가져오는 method (유저)
	@Override
	public List<MenuDto> getMenuList_num(StoreDto dto) {
		
		return session.selectList("getMenuList_user", dto);
	}
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	@Override
	public void deleteMenu(MenuDto dto) {
		session.delete("deleteMenu", dto);	
	}
	
	// 해당 매장의 메뉴를 best로 설정 및 취소하는 method
	@Override
	public void bestOnOff(MenuDto dto) {
		session.update("bestOnOff", dto);	
	}
	
	// 해당 매장의 베스트 메뉴 수를 가져오는 method
	@Override
	public int bestCount(StoreDto dto) {
		
		return session.selectOne("bestCount", dto);
	}
	
	// 해당 매장의 메뉴 전체 정보를 삭제하는 method
	@Override
	public void deleteAllMenu(MenuDto dto) {
		session.delete("deleteAllMenu", dto);	
	}
	
	// 해당 매장의 이름이 변경되면 메뉴 table의 메뉴에서도 storeName을 바꿔주는 method
	@Override
	public int updateStoreOfMenu(StoreDto dto) {
		return session.update("updateStoreOfMenu", dto);
	}
}
