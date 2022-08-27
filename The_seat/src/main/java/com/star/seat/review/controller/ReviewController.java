package com.star.seat.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.order.dto.OrderDto;
import com.star.seat.order.service.OrderService;
import com.star.seat.review.dto.ReviewDto;
import com.star.seat.review.service.ReviewService;
import com.star.seat.store.dto.StoreDto;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	@Autowired
	private OrderService oService;
	
	// 매장 리뷰 관리 페이지로 이동
	@RequestMapping("/store/storeReview.do")
	public ModelAndView storeReview(ReviewDto dto){
		dto.setStoreNum(dto.getNum());
		
		ModelAndView mView = new ModelAndView();
		mView.addObject("reviewList", service.getReviewList(dto).get("reviewList"));
		mView.setViewName("store/storeReview");
		
		return mView;
	}
	
	// 작성한 리뷰 정보를 추가하는 method
	@RequestMapping(value = "/store/addReview.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addReview(ReviewDto dto, HttpServletRequest request){
		// Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
		String realPath=request.getServletContext().getRealPath("/upload");
		String email=(String)request.getSession().getAttribute("email");

		return service.addReview(dto, realPath, email);
	}

	// 해당 매장 리뷰 목록을 불러오는 method
	@RequestMapping(value = "/store/getReview.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getReviewList(ReviewDto dto){
		
		return service.getReviewList(dto);
	}

	// 해당 리뷰를 삭제하는 method
	@RequestMapping(value = "/store/deleteReview.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReview(ReviewDto dto, OrderDto oDto, HttpSession session){
		String email = (String)session.getAttribute("email");
		
		return service.deleteReview(dto, oDto, email);
	}
	
	// 해당 리뷰 정보를 가져오는 method
	@RequestMapping(value = "/store/getReviewData.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getReviewData(ReviewDto dto){
		
		return service.getReviewData(dto);
	}
	
	// 해당 리뷰를 수정하는 method
	@RequestMapping(value = "/store/updateReview.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateReview(ReviewDto dto, HttpServletRequest request){
		// 이메일 정보 넣어주기
		String email=(String)request.getSession().getAttribute("email");
		// Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
		String realPath=request.getServletContext().getRealPath("/upload");
		
		return service.updateReview(dto, email, realPath);
	}
	
	// 매장 관리 페이지에서 유저의 해당 리뷰에 대한 관리자의 리뷰가 존재하는지 여부를 알려주는 method
	// 있으면 true, 없으면 false를 return하게 된다.
	@RequestMapping(value = "/store/getMyReview.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMyReview(ReviewDto dto){
		
		return service.getMyReview(dto);
	}
}