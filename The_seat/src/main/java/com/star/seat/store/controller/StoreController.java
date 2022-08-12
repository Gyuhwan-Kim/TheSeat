package com.star.seat.store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.menu.service.MenuService;
import com.star.seat.order.service.OrderService;
import com.star.seat.review.dto.ReviewDto;
import com.star.seat.review.service.ReviewService;
import com.star.seat.seat.dto.SeatDto;
import com.star.seat.seat.service.SeatService;
import com.star.seat.store.dto.StoreDto;
import com.star.seat.store.service.StoreService;

@Controller
public class StoreController {
	@Autowired
	private StoreService service;
	@Autowired
	private MenuService mService;
	@Autowired
	private OrderService oService;
	@Autowired
	private ReviewService rService;
	@Autowired
	private SeatService seatService;
	
	// 검색 결과 메인 페이지를 요청할 때의 method
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String getList(StoreDto dto, HttpServletRequest request) {
		
		// dto에 지역, 메뉴, 검색어 넣어서 dto라는 이름으로 저장.
		request.setAttribute("searchData", dto);
		
		// 검색 결과 목록을 얻어옴
		service.getList(request, dto);
		
		String email=(String)request.getSession().getAttribute("email");
		if(email != null) {
			// 내가 관리하는 매장 정보를 얻어옴
			request.setAttribute("myStoreList", service.getMyStores(email));
		}

		return "main";
	}
	
	// 매장 추가 링크를 눌러서 요청되는 경로에 대한 method
	@RequestMapping("/newStore.do")
	@ResponseBody
	public Map<String, Object> addStore(HttpServletRequest request){
		Map<String, Object> map=new HashMap<>();
		
		// service에서 매장 정보 DB에 email 정보를 더해줌.
		
		return service.addStore(request);
	}
	
	// 매장 관리 링크를 눌러서 요청되는 경로에 대한 method
	@RequestMapping(value="/store/myStore.do", method=RequestMethod.GET)
	public String myStore(StoreDto dto, HttpServletRequest request) {
		
		// service에서 매장 정보를 DB에서 꺼내와서 request에 넣고
		service.getMyStore(dto, request);
		
		// 페이지 return
		return "store/myStore";
	}
	
	// 매장 태그 추가 링크를 눌러서 요청되는 경로에 대한 method
	@RequestMapping(value = "/addTag.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addTag(StoreDto dto, HttpServletRequest request){
		// service에서 DB에 매장 태그를 추가하고

		return service.addTag(dto, request);
	}
	
	// 매장을 태그를 삭제하는 method
	@RequestMapping(value = "/deleteTag.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteTag(StoreDto dto, HttpServletRequest request) {

		return service.deleteTag(dto, request);
	}
	
	// 관리 매장 정보 수정
	@RequestMapping(value = "/storeUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> storeUpdate(StoreDto dto, HttpServletRequest request){
		
		return service.updateStore(dto, request);
	}
	
	// (로고)사진 업로드 method
	@RequestMapping(value = "/uploadImage.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadImage(StoreDto dto, HttpServletRequest request){
		
		return service.uploadImage(dto, request);
	}
	
	// 매장 On Off method
	@RequestMapping(value = "/storeOnOff.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> storeOnOff(StoreDto dto) {;

		return service.storeOnOff(dto);
	}
	
	// 매장 메뉴 카테고리 추가하는 method
	@RequestMapping(value = "/store/addCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addCategory(StoreDto dto){
		
		service.addCategory(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("beAdded", true);
		
		return map;
	}
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	@RequestMapping(value = "/store/deleteCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCategory(StoreDto dto){
		
		service.deleteCategory(dto);
		
		Map<String, Object> map=new HashMap<>();
		map.put("beDeleted", true);
		
		return map;
	}

	// 매장 상세 정보 페이지로 이동
	@RequestMapping(value = "/store/storeDetail.do",method = RequestMethod.GET)
	public ModelAndView goStoreDetail(SeatDto sDto, StoreDto dto, ReviewDto rDto, ModelAndView mView, HttpServletRequest request) {
		
		service.getMyStore_num(dto, request);
		
		mService.getMenuList_user(dto, request);	
		int storeNum = Integer.parseInt(request.getParameter("num"));
		dto.setNum(storeNum);
		//dto에 num 정보 넣어서 같은 num 의 자리정보 dto 에 담아오기
		
		rDto.setStoreNum(storeNum);
		List<ReviewDto> list=rService.getReviewList(rDto, request);
		
		seatService.getSeat(sDto, mView, request);
		mView.addObject("reviewList", list);
		mView.setViewName("store/storeDetail");
		return mView;
	}
	
	// 매장 리뷰 관리 페이지로 이동
	@RequestMapping("/store/storeReview.do")
	public String storeReview(StoreDto dto, HttpServletRequest request){
		String num = request.getParameter("num");
		request.setAttribute("num", num);
		ReviewDto rDto=new ReviewDto();
		rDto.setStoreNum(dto.getNum());
		
		List<ReviewDto> list=rService.getReviewList(rDto, request);
		
		request.setAttribute("reviewList", list);
		
		return "store/storeReview";
	}
	
	// 매장 주문관리 페이지로 이동
	@RequestMapping("/store/storeOrder")
	public ModelAndView storeOrder(ModelAndView mView,HttpServletRequest request, 
			HttpSession session){
		String num = request.getParameter("num");
		request.setAttribute("num", num);
		oService.getStoreList(mView, request, session);
		mView.setViewName("store/storeOrder");
		return mView;
	}
	
	// 매장 정보를 삭제하는 method
	@RequestMapping(value = "/store/deleteStore.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteStore(StoreDto dto, HttpServletRequest request) {
		
		return service.deleteStore(dto, request);
	}
	
}
