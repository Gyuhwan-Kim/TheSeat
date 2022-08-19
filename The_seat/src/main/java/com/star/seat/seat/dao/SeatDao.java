package com.star.seat.seat.dao;

import com.star.seat.seat.dto.SeatDto;

public interface SeatDao {
	// 매장 자리 정보를 추가하는 method
	public void insertSeat(SeatDto dto);
	// 자리 정보 수정
	public int updateSeat(SeatDto dto);
	// 빈 자리 정보 수정
	public int updateEmptySeat(SeatDto dto);
	// 자리 정보 가져가기
	public SeatDto getSeat(SeatDto dto);
	// 자리 정보 삭제
	public void seatDelete(SeatDto dto);
}
