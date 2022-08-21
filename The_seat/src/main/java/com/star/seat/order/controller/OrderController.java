package com.star.seat.order.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.star.seat.menu.service.MenuService;
import com.star.seat.order.dto.OrderDto;
import com.star.seat.order.service.OrderService;
import com.star.seat.seat.dto.SeatDto;
import com.star.seat.seat.service.SeatService;
import com.star.seat.store.dto.StoreDto;
import com.star.seat.store.service.StoreService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService service;
	@Autowired
	private StoreService sService;
	@Autowired
	private MenuService mService;
	@Autowired
	private SeatService seatService;
	
	// 주문하기
	@RequestMapping(value = "/order/insert.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insert(@RequestBody Map<Integer, Object> dataList){

		return service.orderInsert(dataList);
	}
	
	// 좌석 선택 후 매장 주문 페이지로 이동
	@RequestMapping(value = "/order/order.do", method = RequestMethod.GET)
	public ModelAndView authOrder(StoreDto dto, SeatDto sDto, OrderDto oDto){
		ModelAndView mView = new ModelAndView();
		// StoreDto, SeatDto에는 DB에 저장된 매장 번호가 있고, 이를 이용해서 data를 불러옴
		mView.addObject("dto", sService.getStoreData(dto));
		mView.addObject("menuList", mService.getMenuList(dto));
		mView.addObject("sDto", seatService.getSeat(sDto));
		
		// 매장 상세 페이지의 자리 선택 modal로부터 선택한 자리 번호와 주문 번호를 OrderDto에 담아 주문 페이지로 전달
		mView.addObject("tableNum", oDto.getTableNum());
		mView.addObject("orderNum", oDto.getOrderNum());
		
		mView.setViewName("order/order");
		
		return mView;
	}
	
	// 주문내역 메뉴 상세 AJAX
	@RequestMapping(value = "/order/orderMenu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderMenuDetail (OrderDto dto){
		return service.getOrderMenuList(dto);
	}
	
	// 주문내역 정보 변경 AJAX
	@RequestMapping(value = "/order/updateState.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateState(OrderDto dto, HttpServletRequest request){
		return service.updateState(dto);
	}
	
}
