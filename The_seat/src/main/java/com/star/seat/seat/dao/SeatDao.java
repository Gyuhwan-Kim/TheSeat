package com.star.seat.seat.dao;

import com.star.seat.seat.dto.SeatDto;

public interface SeatDao {
	// 매장 자리 정보를 추가하는 method
	public void insertSeat(SeatDto dto);
	// 자리 정보 수정
	public void updateSeat(SeatDto dto);
	// 자리 정보 가져가기
	public SeatDto getSeat(SeatDto dto);
}
