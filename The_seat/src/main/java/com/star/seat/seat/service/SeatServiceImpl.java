package com.star.seat.seat.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.seat.dao.SeatDao;
import com.star.seat.seat.dto.SeatDto;

@Service
public class SeatServiceImpl implements SeatService {
	
	@Autowired
	private SeatDao dao;
	
	@Override
	public void insertSeat(SeatDto dto) {
		
		dao.insertSeat(dto);
	}

	@Override
	public Map<String, Object> updateSeat(SeatDto dto) {
		Map<String, Object> map=new HashMap<>();
		// 자리 정보 변경 시 update하고, 성공여부를 다르게 return
		if(dao.updateSeat(dto) == 1) {
			map.put("isSuccess", true);
		} else {
			map.put("isSuccess", false);
		}
		
		return map;
	}
	
	@Override
	public Map<String, Object> updateEmptySeat(SeatDto dto) {
		// 주문 시 자리 정보 update하고, 성공 여부에 따라 Map 객체에 다르게 return
		Map<String, Object> map=new HashMap<>();
		if(dao.updateEmptySeat(dto) == 1) {
			map.put("isSuccess", true);
		} else {
			map.put("isSuccess", false);
		}
		
		return map;
	}

	@Override
	public SeatDto getSeat(SeatDto dto) {

		return dao.getSeat(dto);
	};
	
	@Override
	public Map<String, Object> saveSeatImage(MultipartFile mFile, String realPath) {
		//업로드된 파일에 대한 정보를 MultipartFile 객체를 이용해서 얻어낼수 있다.	
		
		//원본 파일명
		String orgFileName=mFile.getOriginalFilename();
		//upload 폴더에 저장할 파일명을 직접구성한다.
		// 1234123424343xxx.jpg
		String saveFileName=System.currentTimeMillis()+orgFileName;
		
		// upload 폴더가 존재하지 않을경우 만들기 위한 File 객체 생성
		// webapp/upload 폴더까지의 실제 경로를 사용
		File upload=new File(realPath);
		if(!upload.exists()) {//만일 존재 하지 않으면
			upload.mkdir(); //만들어준다.
		}
		try {
			//파일을 저장할 전체 경로를 구성한다.  
			String savePath=realPath+File.separator+saveFileName;
			//임시폴더에 업로드된 파일을 원하는 파일을 저장할 경로에 전송한다.
			mFile.transferTo(new File(savePath));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		// json 문자열을 출력하기 위한 Map 객체 생성하고 정보 담기 
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("imagePath", "/upload/"+saveFileName);
		
		return map;
	}

}
