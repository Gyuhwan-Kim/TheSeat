package com.star.seat.review.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.star.seat.order.dto.OrderDto;
import com.star.seat.review.dto.ReviewDto;

public interface ReviewService {
	// 작성한 리뷰 정보를 추가하는 method
	public Map<String, Object> addReview(ReviewDto dto, String realPath, String email);
	
	// 해당 매장 리뷰 정보를 가져오는 method
	public Map<String, Object> getReviewList(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 삭제하는 method
	public Map<String, Object> deleteReview(ReviewDto dto, OrderDto oDto);
	
	// 해당 DB번호의 리뷰 정보를 삭제하는 method(사장님은 사장님것만 삭제)
	public void deleteReview_owner(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 가져오는 method
	public Map<String, Object> getReviewData(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 수정하는 method
	public Map<String, Object> updateReview(ReviewDto dto, String email, String realPath);
	
	// 해당 리뷰 번호로 되어있는 targetNum 정보가 있는지 여부를 알아내는 method
	public Map<String, Object> getMyReview(ReviewDto dto, HttpServletRequest request);
}
