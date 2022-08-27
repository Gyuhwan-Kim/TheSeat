package com.star.seat.review.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.star.seat.order.dao.OrderDao;
import com.star.seat.order.dto.OrderDto;
import com.star.seat.review.dao.ReviewDao;
import com.star.seat.review.dto.ReviewDto;
import com.star.seat.store.dao.StoreDao;
import com.star.seat.store.dto.StoreDto;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private ReviewDao dao;
	@Autowired
	private StoreDao sDao;
	
	// 작성한 리뷰 정보를 추가하는 method
	@Override
	public Map<String, Object> addReview(ReviewDto dto, String realPath, String email) {
		//저장할 파일의 상세 경로
		String filePath = realPath+File.separator;
		//해당 경로를 access 할수 있는 파일 객체 생성
		File f = new File(realPath);
		if(!f.exists()){ //만일  폴더가 존재 하지 않으면
			f.mkdir(); //upload 폴더 만들기 
		}
		
		// upload할 image 정보
		MultipartFile reviewImage = dto.getImageFile();
		if(reviewImage != null) {
			//원본 파일명 
			String orgFileName = reviewImage.getOriginalFilename();
			//upload 폴더에 저장된 파일명 
			String saveFileName = System.currentTimeMillis()+orgFileName;
			dto.setImagePath("/upload/"+saveFileName);
			try {
				//upload 폴더에 파일을 저장한다.
				reviewImage.transferTo(new File(filePath+saveFileName));
			}catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			dto.setImagePath("null");
		}

		dto.setWriter(email);
		
		StoreDto sDto = new StoreDto();
		sDto.setNum(dto.getStoreNum());
		// 해당 매장의 정보를 불러옴
		sDto = sDao.getStoreData(sDto);
		
		// 미리 리뷰 table의 num column에 다음에 들어갈 숫자를 받아
		int num = dao.getSequence();
		
		Map<String, Object> map=new HashMap<>();
		
		// 해당 댓글 작성자의 이메일과 사장님의 이메일이 같으면
		// targetNum에 0을 넣지 않기 위해 해당 review num을 넣어줌
		if(email.equals(sDto.getOwner())){
			// 해당 num data는 매장 관리 페이지에서만 넘어온다
			dto.setTargetNum(dto.getNum());
			dto.setGroupNum(dto.getNum());
			
			// ReviewDto의 num을 sequence의 값으로 갱신
			dto.setNum(num);
			
			// 리뷰 table에 data를 추가하고
			if(dao.addReview(dto) == 1) {
				map.put("isAdded", true);
			} else {
				map.put("isAdded", false);
			}
		} else {
			// 이메일이 달라서 유저인 것이 확인되면
			// 미리 읽어온 sequence의 다음 숫자를 넣어줌.
			dto.setNum(num);
			dto.setGroupNum(num);
			
			// Order table을 수정하기 위해 만듦
			OrderDto oDto = new OrderDto();
			oDto.setOrderNum(dto.getOrderNum());
			oDto.setReviewExist("YES");
			
			// 리뷰 table에 data를 추가하고
			dao.addReview(dto);
			
			// 주문 table에 리뷰의 존재를 업데이트
			dao.reviewExist(oDto);
			
			int newReviewCount = sDto.getReviewCount() + 1;
			// 소수점 두 자리까지 표기되도록 한 후
			String strAvgStar = String.format("%.2f", 
					(sDto.getAvgStar() * sDto.getReviewCount() + dto.getStar()) / newReviewCount);
			// String을 다시 float으로 바꿔서
			float newAvgStar = Float.valueOf(strAvgStar);
			// sDto에 setting
			sDto.setAvgStar(newAvgStar);
			sDto.setReviewCount(1);
			
			if(sDao.updateStore_review(sDto) == 1) {
				map.put("isAdded", true);
				map.put("newAvgStar", newAvgStar);
			} else {
				map.put("isAdded", false);
			}
		}
		
		return map;
	}
	
	// 해당 매장 리뷰 정보를 가져오는 method
	@Override
	public Map<String, Object> getReviewList(ReviewDto dto) {
		// 전달받은 dto에는 DB에 저장된 매장의 number data가 storeNum에 있다.
		Map<String, Object> map = new HashMap<>();

		List<ReviewDto> list = dao.getReviewList(dto);
		
		if(list != null) {
			for(int i = 0; i < list.size(); i++) {
				if(list.get(i).getTargetNum() != 0) {
					list.get(i-1).setReviewCheck("yes");
				}
			}
			map.put("isTaken", true);
			map.put("reviewList", list);
		} else {
			map.put("isTaken", false);
		}
			
		return map;
	}
	
	// 해당 DB번호의 리뷰 정보를 삭제하는 method
	@Override
	public Map<String, Object> deleteReview(ReviewDto dto, OrderDto oDto, String email) {

		StoreDto sDto = new StoreDto();
		sDto.setNum(dto.getStoreNum());
		sDto = sDao.getStoreData(sDto);
		
		Map<String, Object> map=new HashMap<>();

		if(sDto.getOwner().equals(email)) {
			// 매장 리뷰 관리 페이지에서는 주문 번호에 대한 data가 없다.
			if(dao.deleteReview(dto) == 1) {
				map.put("isDeleted", true);
			} else {
				map.put("isDeleted", false);
			}
		} else {
			// 두 Dto로 주문 번호인 orderNum이 담겨서 온다
			oDto.setReviewExist("NO");
			
			// 넘어오는 주문번호로 리뷰 삭제
			dao.deleteReview(dto);
			// 리뷰의 존재를 업데이트
			dao.reviewExist(oDto);
			
			// 평균 별점을 다시 계산한 후
			String strAvgStar = String.format("%.2f", dao.getAvgStar(dto));

			// String을 다시 float으로 바꿔서
			float newAvgStar = Float.valueOf(strAvgStar);
			// sDto에 setting
			sDto.setAvgStar(newAvgStar);
			sDto.setReviewCount(-1);

			// 매장의 평점도 업데이트 함
			if(sDao.updateStore_review(sDto) == 1) {
				map.put("isDeleted", true);
				map.put("newAvgStar", newAvgStar);
			} else {
				map.put("isDeleted", false);
			}
		}
		
		return map;
	}
	
	// 리뷰 수정 modal에 해당 DB번호의 리뷰 정보를 가져오는 method
	@Override
	public Map<String, Object> getReviewData(ReviewDto dto) {
		Map<String, Object> map = new HashMap<>();
		
		dto = dao.getReviewData(dto);
		if(dto != null) {
			map.put("isSuccess", true);
			map.put("reviewData", dto);
		} else {
			map.put("isSuccess", false);
		}
		
		return map;
	}
	
	// 해당 DB번호의 리뷰 정보를 수정하는 method
	@Override
	public Map<String, Object> updateReview(ReviewDto dto, String email, String realPath) {
		// 이메일 정보 넣어주기
		dto.setWriter(email);
		
		//저장할 파일의 상세 경로
		String filePath=realPath+File.separator;
		
		// upload할 image 정보
		MultipartFile reviewImage=dto.getImageFile();
		if(reviewImage!=null) {
			//원본 파일명 
			String orgFileName=reviewImage.getOriginalFilename();
			//upload 폴더에 저장된 파일명 
			String saveFileName=System.currentTimeMillis()+orgFileName;
			dto.setImagePath("/upload/"+saveFileName);
			try {
				//upload 폴더에 파일을 저장한다.
				reviewImage.transferTo(new File(filePath+saveFileName));
			}catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			dto.setImagePath("null");
		}

		// 리뷰를 업데이트 하고
		dao.updateReview(dto);
		
		// 평균 별점을 다시 계산한 후
		String strAvgStar = String.format("%.2f", dao.getAvgStar(dto));

		// String을 다시 float으로 바꿔서
		float newAvgStar = Float.valueOf(strAvgStar);
		// sDto에 setting
		StoreDto sDto = new StoreDto();
		sDto.setAvgStar(newAvgStar);
		sDto.setReviewCount(0);
		sDto.setNum(dto.getStoreNum());

		Map<String, Object> map=new HashMap<>();
		// 매장의 평점도 업데이트 함
		if(sDao.updateStore_review(sDto) == 1) {
			map.put("isUpdated", true);
			map.put("newAvgStar", newAvgStar);
		} else {
			map.put("isUpdated", false);
		}
		
		return map;
	}
	
	// 해당 리뷰 번호로 되어있는 targetNum 정보가 있는지 여부를 알아내는 method
	@Override
	public Map<String, Object> getMyReview(ReviewDto dto) {
		Map<String, Object> map = new HashMap<>();
		
		// DB에서 가져온 답글 data를 받아서
		dto = dao.getMyReview(dto);
		// data 유무에 따라 다르게 return
		if(dto != null) {
			map.put("isChecked", true);
			map.put("ownerReviewData", dto);
		} else {
			map.put("isChecked", false);
		}
		
		return map;
	}
}
