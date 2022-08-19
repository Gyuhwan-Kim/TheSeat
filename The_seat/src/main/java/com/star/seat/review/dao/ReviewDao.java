package com.star.seat.review.dao;

import java.util.List;

import com.star.seat.order.dto.OrderDto;
import com.star.seat.review.dto.ReviewDto;

public interface ReviewDao {
	// sequence의 다음 숫자를 가져오는 method
	public int getSequence();
	
	// 작성한 리뷰 정보를 추가하는 method
	public void addReview(ReviewDto dto);
	
	// 해당 매장 리뷰 정보를 가져오는 method
	public List<ReviewDto> getReviewList(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 삭제하는 method(유저는 사장님까지 삭제)
	public void deleteReview(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 삭제하는 method(사장님은 사장님것만 삭제)
	public void deleteReview_owner(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 가져오는 method
	public ReviewDto getReviewData(ReviewDto dto);
	
	// 해당 DB번호의 리뷰 정보를 수정하는 method
	public void updateReview(ReviewDto dto);
	
	// 해당 주문 번호에 해당하는 review 존재 여부를 조정하는 method
	public void reviewExist(OrderDto dto);
	
	// 해당 리뷰 번호로 되어있는 targetNum 정보가 있는지 여부를 알아내는 method
	public ReviewDto getMyReview(ReviewDto dto);
	
	// 해당 DB 번호로 되어있는 매장에 대한 평균 별점을 얻어내는 method
	public float getAvgStar(ReviewDto dto);
	
	// 해당 orderNum에 준 내 별점 정보를 얻어내는 method
	public int getMyStar(ReviewDto dto);
	
	// 해당 매장 DB 번호로 된 모든 리뷰를 삭제하는 method
	public void deleteAllReview(ReviewDto dto);
}
