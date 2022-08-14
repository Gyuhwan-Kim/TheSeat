package com.star.seat.store.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.star.seat.paging.dto.PagingDto;
import com.star.seat.store.dto.StoreDto;

public interface StoreService {
	// 새로운 매장을 추가하는 method
	public Map<String, Object> addStore(String email);
	
	// 사장님의 매장 정보 목록을 불러오는 method
	public List<StoreDto> getMyStores(String email);
	
	// 사장님의 매장 정보 하나를 불러오는 method(이메일과 rnum 이용)
	public StoreDto getMyStore(String email, StoreDto dto);
	
	// (사장님의) 매장 정보 하나를 불러오는 method(해당 매장 DB 번호 이용)
	public void getMyStore_num(StoreDto dto, HttpServletRequest request);
	
	// 매장 검색목록 불러오는 method
	public PagingDto<StoreDto> getList(String strPageNum, StoreDto dto);
	
	// 매장 태그를 추가하는 method
	public Map<String, Object> addTag(String email, StoreDto dto);
	
	// 매장 태그를 삭제하는 method
	public Map<String, Object> deleteTag(String email, StoreDto dto);
	
	// 매장 정보(이름, 주소, 시간)를 수정하는 method
	public Map<String, Object> updateStore(StoreDto dto);
	
	// 이미지를 업로드하는 method
	public Map<String, Object> uploadImage(StoreDto dto, HttpServletRequest request);
	
	// 매장 On Off method
	public Map<String, Object> storeOnOff(StoreDto dto);
	
	// 매장 카테고리를 추가하는 method
	public void addCategory(StoreDto dto);
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	public void deleteCategory(StoreDto dto);
	
	// 매장 정보를 삭제하는 method
	public Map<String, Object> deleteStore(StoreDto dto, String email);
}
