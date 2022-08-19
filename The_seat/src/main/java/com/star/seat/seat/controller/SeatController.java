package com.star.seat.seat.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.seat.dto.SeatDto;
import com.star.seat.seat.service.SeatService;

@Controller
public class SeatController {

	@Autowired
	private SeatService service;
	
	//매장 자리관리 페이지로 이동 요청 처리
	@RequestMapping("/store/storeSeat")
	public ModelAndView getSeat(SeatDto dto) {
		ModelAndView mView = new ModelAndView();
		
		// 넘겨받은 SeatDto에는 DB에 저장된 매장의 number data가 있음
		mView.addObject("sDto", service.getSeat(dto));
		mView.setViewName("store/storeSeat");
		return mView;
	}
	
	//ajax 자리 이미지 업로드 요청처리
	@RequestMapping(value = "/store/ajax_seat_upload",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> AjaxSeatUpload(HttpServletRequest request,
			@RequestParam MultipartFile image){
		
		//서비스를 이용해서 이미지를 upload 폴더에 저장하고 리턴되는 Map 을 리턴해서 json 문자열 응답하기
		return service.saveSeatImage(request, image);
	}
	
	//ajax 자리 이미지 업로드 요청처리
	@RequestMapping(value = "/seat/emptySeat",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateEmptySeat(HttpServletRequest request, SeatDto dto){
		
		service.updateEmptySeat(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}
	
	
	
	@RequestMapping(value = "/store/updateSeat",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSeat(SeatDto dto, HttpServletRequest request) {
		service.updateSeat(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}
}
