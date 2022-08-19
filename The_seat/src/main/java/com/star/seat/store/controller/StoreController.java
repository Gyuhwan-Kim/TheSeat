package com.star.seat.store.controller;

import java.util.ArrayList;
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
import com.star.seat.paging.dto.PagingDto;
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
	public ModelAndView getList(StoreDto dto, HttpServletRequest request) {
		String strPageNum = (String)request.getAttribute("pageNum");
		
		ModelAndView mView = new ModelAndView();
		
		// dto에 지역, 메뉴, 검색어 넣어서 searchData라는 이름으로 저장.
		mView.addObject("searchData", dto);
		
		// 검색 결과 목록을 얻어옴
		PagingDto<StoreDto> pDto = service.getList(strPageNum, dto);
		mView.addObject("list", pDto.getDataList());
		mView.addObject("startPageNum", pDto.getStartPageNum());
		mView.addObject("endPageNum", pDto.getEndPageNum());
		mView.addObject("totalPageCount", pDto.getTotalPageCount());
		mView.addObject("pageNum", pDto.getPageNum());
		
		String email=(String)request.getSession().getAttribute("email");
		if(email != null) {
			// 내가 관리하는 매장 정보를 얻어옴
			mView.addObject("myStoreList", service.getMyStores(email));
		}
		
		mView.setViewName("main");

		return mView;
	}
	
	// 매장 추가 링크를 눌러서 요청되는 경로에 대한 method
	@RequestMapping("/newStore.do")
	@ResponseBody
	public Map<String, Object> addStore(HttpSession session){
		String email = (String)session.getAttribute("email");
				
		return service.addStore(email);
	}
	
	// 매장 관리 링크를 눌러서 요청되는 경로에 대한 method
	@RequestMapping(value="/store/myStore.do", method=RequestMethod.GET)
	public ModelAndView myStore(StoreDto dto, HttpSession session) {
		String email = (String)session.getAttribute("email");
		
		// service에서 매장 정보를 DB에서 꺼내온 data로 dto 갱신
		dto = service.getStoreData(dto);
		
		String[] tagList = {}; 
		// 만약 dto에 매장 tag 정보가 있다면 String array를 덮어씀
		if(dto.getStoreTag() != null) {
			tagList = dto.getStoreTag().split(",");
		}
		
		ModelAndView mView = new ModelAndView();
		mView.addObject("dto", dto);
		mView.addObject("tagList", tagList);
		mView.setViewName("store/myStore");
		
		// 페이지와 data return
		return mView;
	}
	
	// 매장 태그 추가 링크를 눌러서 요청되는 경로에 대한 method
	@RequestMapping(value = "/addTag.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addTag(StoreDto dto, HttpSession session){
		String email = (String)session.getAttribute("email");
		
		// service에서 DB에 매장 태그를 추가하고

		return service.addTag(email, dto);
	}
	
	// 매장을 태그를 삭제하는 method
	@RequestMapping(value = "/deleteTag.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteTag(StoreDto dto, HttpSession session) {
		String email = (String)session.getAttribute("email");
		
		return service.deleteTag(email, dto);
	}
	
	// 관리 매장 정보 수정
	@RequestMapping(value = "/storeUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> storeUpdate(StoreDto dto){
		
		return service.updateStore(dto);
	}
	
	// (로고)사진 업로드 method
	@RequestMapping(value = "/uploadImage.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadImage(StoreDto dto, HttpServletRequest request){
		// Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
		String realPath=request.getServletContext().getRealPath("/upload");
		String email = (String)request.getSession().getAttribute("email");
		
		return service.uploadImage(realPath, dto, email);
	}
	
	// 매장 On Off method
	@RequestMapping(value = "/storeOnOff.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> storeOnOff(StoreDto dto) {;

		return service.storeOnOff(dto);
	}

	// 매장 상세 정보 페이지로 이동
	@RequestMapping(value = "/store/storeDetail.do",method = RequestMethod.GET)
	public ModelAndView goStoreDetail(StoreDto dto, SeatDto sDto, HttpServletRequest request) {
		ModelAndView mView = new ModelAndView();
		// 번호 정보가 담긴 dto를 통해 DB에서 매장 data를 불러옴
		StoreDto storeData = service.getStoreData(dto);
		mView.addObject("dto", storeData);
		mView.addObject("tagList", storeData.getStoreTag());
		mView.addObject("categoryList", storeData.getCategory());
		
		// 번호 정보가 담긴 dto를 통해 DB에서 메뉴 List를 불러온 것을 그대로 ModelAndView 객체에 담아줌
		mView.addObject("menuList", mService.getMenuList(dto));
	
		// dto의 number 정보는 DB에 저장된 매장의 번호이다.
		// 그 값을 받아 service에 전해준다.
		ReviewDto rDto = new ReviewDto();
		rDto.setStoreNum(dto.getNum());
		
		mView.addObject("reviewList", rService.getReviewList(rDto));
		
		seatService.getSeat(sDto, mView, request);
		
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
		
		request.setAttribute("reviewList", rService.getReviewList(rDto));
		
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
	public Map<String, Object> deleteStore(StoreDto dto, HttpSession session) {
		String email = (String)session.getAttribute("email");
		
		return service.deleteStore(dto, email);
	}
	
}
