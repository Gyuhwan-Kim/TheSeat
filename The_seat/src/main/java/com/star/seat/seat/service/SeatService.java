package com.star.seat.seat.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.seat.dto.SeatDto;

public interface SeatService {
	//자리 정보 저장
	public void insertSeat(SeatDto dto, HttpServletRequest request);
	//자리 정보 수정
	public void updateSeat(SeatDto dto);
	//빈 자리 정보 수정
	public void updateEmptySeat(SeatDto dto);
	//자리 정보 겟
	public SeatDto getSeat(SeatDto dto);
	// 자리 이미지 업로드
	public Map<String, Object> saveSeatImage(MultipartFile mFile, String realPath);
}
