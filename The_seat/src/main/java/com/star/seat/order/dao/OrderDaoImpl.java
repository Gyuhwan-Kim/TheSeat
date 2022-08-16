package com.star.seat.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

import com.star.seat.order.dto.OrderDto;

@Repository
public class OrderDaoImpl implements OrderDao{

	@Autowired
	private SqlSession session;

	//email 이 같은 주문내역 불러오기
	@Override
	public List<OrderDto> getList(OrderDto dto) {
		return session.selectList("order.getOrderList", dto);
	}
	
	//num 이 같은 주문내역
	@Override
	public List<OrderDto> getStoreList(OrderDto dto) {
		return session.selectList("order.getStoreOrderList", dto);
	}
	
	//orderNum 이 같은 주문내역의 menu, menuCount, price 가져오기
	@Override
	public List<OrderDto> getOrderMenuList(OrderDto dto) {
		
		return session.selectList("order.getOrderMenuList", dto);
	}
	
	//주문하기
	@Override
	public void insert(OrderDto dto) {
		session.insert("order.insertOrder", dto);
	}
	
	//주문취소
	@Override
	public void delete(int orderNum) {
		session.delete("Order.deleteOrder",orderNum);
	}

	@Override
	public int getStoreCount(int num) {
		return session.selectOne("order.getStoreCount", num);
	}

	@Override
	public void updateState(OrderDto dto) {
		session.update("order.updateState", dto);
	}

	// 해당 매장 번호로 된 모든 주문 내역을 삭제하는 method
	@Override
	public void deleteAllOrder(OrderDto dto) {
		session.delete("deleteAllOrder", dto);
	}

	@Override
	public void deleteEmailOrder(OrderDto dto) {
		session.delete("deleteEmailOrder", dto);
	}
}
