package com.star.seat.store.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.star.seat.store.dto.StoreDto;

public interface StoreDao {
	
	// 새로운 매장을 추가하는 method
	public int addStore(String email);
	
	// 사장님의 매장 정보 목록을 불러오는 method
	public List<StoreDto> getMyStores(String email);
	
	// 매장 정보 하나를 불러오는 method
	public StoreDto getStoreData(StoreDto dto);
	
	// 매장 검색목록 불러오는 method
	public List<StoreDto> getList(StoreDto dto);
	
	// 매장 태그를 추가하는 method
	// 사실상 update를 이용하는 것
	public int addTag(StoreDto dto);
	
	// 매장 태그를 삭제하는 method
	// 사실상 update를 이용하는 것
	public int deleteTag(StoreDto dto);
	
	// 매장 정보(이름, 주소, 시간)를 수정하는 method
	public int updateStore(StoreDto dto);
	
	// 이미지를 업로드하는 method
	public int updateImage(StoreDto dto);

	// 매장 On Off method
	public int storeOnOff(StoreDto dto);
	
	// 매장 정보를 삭제하는 method
	public int deleteStore(StoreDto dto);
	
	// 매장의 평균 별점과 리뷰 수를 수정하는 method
	public int updateStore_review(StoreDto dto);
}
