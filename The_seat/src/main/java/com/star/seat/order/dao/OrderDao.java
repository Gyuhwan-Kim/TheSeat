package com.star.seat.order.dao;

import java.util.List;

import com.star.seat.order.dto.OrderDto;

public interface OrderDao {
	
	// 같은 email 주문내역 얻어오기
	public List<OrderDto> getList(OrderDto dto);
	// 같은 num 주문내역 얻어오기
	public List<OrderDto> getStoreList(OrderDto dto);
	
	//orderNum 이 같은 주문내역의 menu, menuCount, price 가져오기
	public List<OrderDto> getOrderMenuList(OrderDto dto);
	// 주문하기
	public void insert(OrderDto dto);
	// 주문 정보 상태 변경
	public int updateState(OrderDto dto);
	//orderNum 으로 주문정보 삭제(주문 취소)
	public void delete(int orderNum);
	
	// 해당 매장 번호로 된 모든 주문 내역을 삭제하는 method
	public void deleteAllOrder(OrderDto dto);
	// email 번호로 된 모든 주문 내역을 삭제하는 method
	public void deleteEmailOrder(OrderDto dto);
}
