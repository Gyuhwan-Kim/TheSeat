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

	// 해당 매장의 메뉴 정보를 가져오는 method (사장님)
	@Override
	public List<MenuDto> getMenuList(StoreDto dto) {

		return session.selectList("getMenuList", dto);
	}
	
	// 해당 매장의 메뉴 정보를 가져오는 method (유저)
	@Override
	public List<MenuDto> getMenuList_num(StoreDto dto) {
		
		return session.selectList("getMenuList_user", dto);
	}
	
	// 매장 카테고리를 추가하는 method
	// 사실상 update를 이용하는 것
	@Override
	public int addCategory(StoreDto dto) {
		return session.update("addCategory", dto);
	}
	
	// 매장 카테고리를 추가하는 method
	// 사실상 update를 이용하는 것
	@Override
	public int deleteCategory(StoreDto dto) {
		return session.update("addCategory", dto);
	}
	
	// 해당 매장의 메뉴 정보를 추가하는 method
	@Override
	public int addMenu(MenuDto dto) {
		return session.insert("addMenu", dto);
	}
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	@Override
	public int deleteMenu(MenuDto dto) {
		return session.delete("deleteMenu", dto);	
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
}
