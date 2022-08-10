package com.star.seat.store.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.star.seat.store.dto.StoreDto;

@Repository
public class StoreDaoImpl implements StoreDao{
	@Autowired
	private SqlSession session;
	
	// 새로운 매장을 추가하는 method
	@Override
	public int addStore(String email) {
		return session.insert("addStore", email);
	}
	
	// 사장님의 매장 정보 목록을 불러오는 method
	@Override
	public List<StoreDto> getMyStores(String email) {
		List<StoreDto> list=session.selectList("getMyStores", email);
		return list;
	}
	
	// 사장님의 매장 정보 하나를 불러오는 method(이메일과 rnum 이용)
	@Override
	public StoreDto getMyStore(StoreDto dto) {
		
		StoreDto myDto=session.selectOne("getMyStore", dto);
		
		return myDto;
	}
	
	// (사장님의) 매장 정보 하나를 불러오는 method(해당 매장 DB 번호 이용)
	@Override
	public StoreDto getMyStore_num(StoreDto dto) {
		StoreDto myDto=session.selectOne("getMyStore_num", dto);
		
		return myDto;
	}
	
	// 매장 검색 목록 불러오는 method
	@Override
	public List<StoreDto> getList(StoreDto dto) {

		return session.selectList("getList", dto);
	}
	
	// 검색한 전체 매장 수를 얻어오는 method
	@Override
	public int getListCount(StoreDto dto) {
		return session.selectOne("getListCount", dto);
	}
	
	// 매장 태그를 추가하는 method
	// 사실상 update 이용하는 것
	@Override
	public int addTag(StoreDto dto) {
		return session.update("addTag", dto);
	}
	
	// 매장 태그를 삭제하는 method
	// 사실상 update를 이용하는 것
	@Override
	public int deleteTag(StoreDto dto) {
		return session.update("addTag", dto);
	}
	
	// 매장 정보(이름, 주소, 시간)를 수정하는 method
	@Override
	public int updateStore(StoreDto dto) {
		return session.update("updateStore", dto);	
	}
	
	// 이미지를 업로드하는 method
	@Override
	public int updateImage(StoreDto dto) {
		return session.update("updateImage", dto);
	}
	
	// 매장 On Off method
	@Override
	public int storeOnOff(StoreDto dto) {
		return session.update("storeOnOff", dto);	
	}
	
	// 매장 카테고리를 추가하는 method
	// 사실상 update를 이용하는 것
	@Override
	public void addCategory(StoreDto dto) {
		session.update("addCategory", dto);
	}
	
	// 매장 카테고리를 추가하는 method
	// 사실상 update를 이용하는 것
	@Override
	public void deleteCategory(StoreDto dto) {
		session.update("addCategory", dto);
	}
	
	// 매장 정보를 삭제하는 method
	@Override
	public void deleteStore(StoreDto dto) {
		session.delete("deleteStore", dto);	
	}
}
