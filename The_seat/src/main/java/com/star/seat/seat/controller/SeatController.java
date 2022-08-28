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
	
	//ajax 자리 이미지 업로드 요청처리
	@RequestMapping(value = "/store/ajax_seat_upload",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxSeatUpload(HttpServletRequest request,
			@RequestParam MultipartFile imageFile){
		// webapp/upload 폴더까지의 실제 경로 얻어내기 
		String realPath = request.getServletContext().getRealPath("/upload");
		
		//업로드된 파일에 대한 정보를 MultipartFile 객체를 이용해서 얻어낼수 있다.
		//서비스를 이용해서 이미지를 upload 폴더에 저장하고 리턴되는 Map 을 리턴해서 json 문자열 응답하기
		return service.saveSeatImage(imageFile, realPath);
	}
	
	// 주문 시 자리 정보 update 요청에 대한 method
	@RequestMapping(value = "/seat/emptySeat", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateEmptySeat(SeatDto dto){
		// 주문 시 빈 자리와 사용 중인 자리 정보를 update
		return service.updateEmptySeat(dto);
	}
	
	@RequestMapping(value = "/store/updateSeat", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSeat(SeatDto dto) {
		// 매장 관리 페이지에서 자리 정보 update
		return service.updateSeat(dto);
	}
}
