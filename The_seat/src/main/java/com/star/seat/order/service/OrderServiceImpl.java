package com.star.seat.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.star.seat.order.dao.OrderDao;
import com.star.seat.order.dto.OrderDto;
import com.star.seat.review.dao.ReviewDao;
import com.star.seat.review.dto.ReviewDto;
import com.star.seat.seat.dao.SeatDao;
import com.star.seat.seat.dto.SeatDto;
import com.star.seat.store.dao.StoreDao;
import com.star.seat.store.dto.StoreDto;



@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDao dao;
	@Autowired
	private ReviewDao rDao;
	@Autowired
	private StoreDao sDao;
	@Autowired
	private SeatDao stDao;
	
	//갤러리 이미지 list
	@Override
	public Map<String, Object> getList(String strPageNum, String email) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=6;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
	   
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;

		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
	   
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum-1) * PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		//startRowNum 과 endRowNum  을 OrderDto 객체에 담고
		OrderDto dto = new OrderDto();
		dto.setEmail(email);
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
	   
		//email 이 담긴 dto객체로 OrderDao 객체를 이용해서 주문 목록을 얻어온다.
		List<OrderDto> list = dao.getList(dto);
		ReviewDto rDto = new ReviewDto();
		StoreDto sDto = new StoreDto();
	    for(int i = 0; i < list.size(); i++) {
	    	// 각 주문번호 정보에 해당 매장의 평균 별점과
	    	// 해당 주문 번호에 대한 내 별점 담기
	    	int num = list.get(i).getNum(); // 매장 DB 번호
	    	sDto.setNum(num);
	    	sDto = sDao.getStoreData(sDto);
	    	// 가져온 매장 data의 매장 이름을 List의 값에 넣어줌
	    	list.get(i).setStoreName(sDto.getStoreName());
	    	// 해당 매장의 번호로 평균 별점을 가져옴
	    	float avgStar = sDto.getAvgStar();
	    	list.get(i).setAvgStar(avgStar);
	    	
	    	// i번째 주문의 주문 번호를 받아서
	    	int orderNum = list.get(i).getOrderNum();
	    	rDto.setOrderNum(orderNum);
	    	// 해당 매장의 주문 번호로 내 별점을 가져옴
	    	// 하지만 리뷰 테이블에 정보가 없으면 에러를 발생시키기 때문에
	    	// 만약 해당 주문 번호의 review 존재가 NO라면 myStar=0
	    	int myStar = 0;
	    	// 존재가 YES라면
	    	if(list.get(i).getReviewExist().equals("YES")) {
	    		// 해당 매장의 주문번호로 별점을 가져옴
	    		myStar=rDao.getMyStar(rDto);
	    	}
	    	list.get(i).setMyStar(myStar);
	    	
			// 매장 주인의 이메일과 접속 이메일이 겹치면 yes로
			// yes라면 review 등록 버튼을 disabled로 출력할 것.
			if(sDto.getOwner().equals(email)) {
				list.get(i).setOwner("yes");
			} else {
				list.get(i).setOwner("no");
			}
	    }
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
	   
		//전체 row 의 갯수
		int totalRow = list.size();
		//전체 페이지의 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum = totalPageCount; //보정해 준다. 
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);	//order list
		map.put("startPageNum", startPageNum);	//시작 페이지 번호
		map.put("endPageNum", endPageNum);	//끝 페이지 번호
		map.put("pageNum", pageNum);	//현재 페이지 번호
		map.put("totalPageCount", totalPageCount);	//모든 페이지 count
		
		return map;
	}
	
	//매장번호가 같은 주문내역 가져가기
	@Override
	public Map<String, Object> getStoreOrderList(String strPageNum, OrderDto dto) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=100;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
	   
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;

		// 페이지 번호는 매개변수로 전달받음
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
	   
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum-1) * PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;
		
		//startRowNum 과 endRowNum  을 OrderDto 객체에 담고
		// 매장 번호에 해당하는 num 은 이미 가지고 있다.
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
	   
		//num 담긴 dto객체로 OrderDao 객체를 이용해서 주문 목록을 얻어온다.
		List<OrderDto> list = dao.getStoreList(dto);
	   
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
	   
		//전체 row 의 갯수
		int totalRow = list.size();
		//전체 페이지의 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum = totalPageCount; //보정해 준다. 
		}

		Map<String, Object> map = new HashMap<>();
		map.put("orderList", list);	//order list
		map.put("startPageNum", startPageNum);	//시작 페이지 번호
		map.put("endPageNum", endPageNum);	//끝 페이지 번호
		map.put("pageNum", pageNum);	//현재 페이지 번호

		return map;
	}
	
	//주문하기
	@Transactional
	@Override
	public Map<String, Object> orderInsert(@RequestBody Map<Integer, Object> dataList) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		ObjectMapper objectMapper = new ObjectMapper();
		for(int i = 0; i < dataList.size()-1; i++) {
			OrderDto dto = objectMapper.convertValue(dataList.get(i), OrderDto.class);
			
			//주문 내용을 DB에 넣음
			dao.insert(dto);
		}
		
		SeatDto stDto = objectMapper.convertValue(dataList.get(dataList.size()-1), SeatDto.class);
		// 자리 정보를 넣음
		if(stDao.updateEmptySeat(stDto) == 1) {
			map.put("isSuccess", true);
		} else {
			map.put("isSuccess", false);
		}

		return map;
	}
	
	//주문번호가 같은 주문내용 가져가기
	@Override
	public Map<String, Object> getOrderMenuList(OrderDto dto) {
		List<OrderDto> list = dao.getOrderMenuList(dto);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("list",list);
		return map;
	}

	@Transactional
	@Override
	public Map<String, Object> updateState(OrderDto dto) {
		Map<String, Object> map=new HashMap<String, Object>();
		if(dao.updateState(dto) >= 1) {
			map.put("isSuccess",true);
		} else {
			map.put("isSuccess",false);
		}

		return map;
	}

	@Transactional
	@Override
	public void deleteEmailOrder(OrderDto dto) {
		dao.deleteEmailOrder(dto);
	}
}
