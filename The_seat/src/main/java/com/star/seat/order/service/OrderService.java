package com.star.seat.order.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.order.dto.OrderDto;
import com.star.seat.seat.dto.SeatDto;

public interface OrderService {
	// email로 회원이 주문한 내역 정보 가져오기
	public Map<String, Object> getList(String strPageNum, String email);
	// num 이 같은 주문 내역 정보 가져오기
	public Map<String, Object> getStoreOrderList(String strPageNum, OrderDto dto);
	//orderNum 이 같은 주문내역의 menu, menuCount, price 가져오기
	public Map<String, Object> getOrderMenuList(OrderDto dto);
	//주문 상태정보 수정
	public Map<String, Object> updateState(OrderDto dto);
	// 주문정보 입력하기
	public Map<String, Object> orderInsert(@RequestBody Map<Integer, Object> orderList);
	// emaill의 주문 내역 삭제하기
	public void deleteEmailOrder(OrderDto dto);
}
