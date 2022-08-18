package com.star.seat.menu.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.star.seat.menu.dao.MenuDao;
import com.star.seat.menu.dto.MenuDto;
import com.star.seat.store.dao.StoreDao;
import com.star.seat.store.dto.StoreDto;

@Service
public class MenuServiceImpl implements MenuService{
	@Autowired
	private MenuDao dao;
	@Autowired
	private StoreDao sDao;
	
	// 해당 매장의 메뉴 정보를 가져오는 method (매장 관리 페이지)
	@Override
	public List<MenuDto> getMenuList(String email, StoreDto sDto) {
		sDto.setOwner(email);

		// 요청 시 넘겨받은 매장의 DB 번호와 email 값으로 해당 매장의 메뉴 정보를 불러온다.

		return dao.getMenuList(sDto);
	}
	
	// 해당 매장의 메뉴 정보를 가져오는 method (유저)
	@Override
	public void getMenuList_user(StoreDto sDto, HttpServletRequest request) {
		List<MenuDto> list=dao.getMenuList_num(sDto);
		request.setAttribute("menuList", list);
	}
	
	// 매장 카테고리를 추가하는 method
	@Override
	public Map<String, Object> addCategory(String email, StoreDto dto) {
		// dto에는 해당 매장 번호가 있다. 추가적으로 email 정보를 넣어준다.
		dto.setOwner(email);
		// 입력한 tag의 정보를 읽어서
		String newCategory = dto.getCategory();
		
		// DB에서 해당 번호의 매장 정보로 dto를 갱신한 뒤
		dto = sDao.getStoreData(dto);
		
		// 우선 기본값을 빈 String으로 함 (null 인 경우)
		String strCategories = "";
		// DB의 내용이 null이 아니면 위의 값으로 갱신하되, dummy data를 넣어준다
		if(dto.getCategory() != null) {
			strCategories = dto.getCategory() + ",empty";
		}
		// dummy data를 포함한 String array로 변형
		// 길이를 +1 하는 일종의 눈속임
		String[] categories = strCategories.split(",");
		// String array의 마지막 dummy 자리에 추가한 category 대입
		categories[categories.length-1] = newCategory;
		// array 각 성분이 , 로 구분된 String으로 바꿔서 갱신
		strCategories = String.join(",", categories);
		
		// DB에서 받아온 dto에 넣은 다음에
		dto.setCategory(strCategories);
		
		Map<String, Object> map=new HashMap<>();
		// dto를 넣어서 update
		if(dao.addCategory(dto) == 1) {
			map.put("isAdded", true);
		} else {
			map.put("isAdded", false);
		}

		return map;
	}
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	@Override
	public Map<String, Object> deleteCategory(String email, StoreDto dto) {
		// dto에는 해당 매장 번호가 있다. 추가적으로 email 정보를 넣어준다.
		dto.setOwner(email);
		// 삭제할 tag의 정보를 읽어서
		String category=dto.getCategory();
		
		// DB에서 해당 번호의 매장 정보로 dto를 갱신한 뒤
		dto = sDao.getStoreData(dto);
		
		// DB의 내용을 , 로 구분해서 String array로 만들어주고
		String[] categories = dto.getCategory().split(",");
		
		// 새로운 array를 만들어서 거기에 하나씩 담아줌.
		List<String> list=new ArrayList<>();
		for(int i=0; i<categories.length; i++) {
			list.add(categories[i]);
		}
		
		// array에서 없앤다음
		list.remove(list.indexOf(category));

		// array 각 성분이 , 로 구분된 String으로 바꿔서
		String strCategories=String.join(",", list);
		// DB에서 받아온 dto에 넣은 다음에
		dto.setCategory(strCategories);

		Map<String, Object> map=new HashMap<>();
		// dto를 넣어서 update
		if(dao.deleteCategory(dto) == 1) {
			map.put("isDeleted", true);
		} else {
			map.put("isDeleted", false);
		}

		return map;
	}
	
	// 해당 매장의 메뉴 정보를 추가하는 method
	@Override
	public Map<String, Object> addMenu(MenuDto dto, String email, String realPath) {
		// 매장 정보를 담을 sDto를 만들어 
		StoreDto sDto = new StoreDto();
		// dto의 storeNum과 session의 email을 담아
		sDto.setNum(dto.getStoreNum());
		sDto.setOwner(email);
		
		Map<String, Object> map=new HashMap<>();
		// 저장할 파일의 상제 경로
		String filePath=realPath+File.separator;
		// 해당 경로에 접근할 수 있는 File 객체 생성
		File f=new File(realPath);
		// 만일 폴더가 존재하지 않으면 만듦
		if(!f.exists()) {
			f.mkdir();
		}
		
		// upload할 image 정보
		MultipartFile imageFile=dto.getImageFile();
		// 원본 파일 명
		String orgImageName=imageFile.getOriginalFilename();
		// 저장할 파일 명
		String saveImageName=System.currentTimeMillis()+orgImageName;
		
		try {
			// folder에 image를 저장
			imageFile.transferTo(new File(filePath+saveImageName));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		// dto에는 storeNum, file, menu name, price, content, category 가 들어있다.
		// file은 이미 저장했고, 경로만 dto에 담에
		dto.setMenuImage("/upload/"+saveImageName);
		
		// DB 정보를 추가한다.
		if(dao.addMenu(dto) == 1) {
			map.put("isAdded", true);
		} else {
			map.put("isAdded", false);
		}
		
		return map;
	}
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	public Map<String, Object> deleteMenu(String email, MenuDto dto) {
		// 매장 정보를 담을 sDto를 만들어 
		StoreDto sDto = new StoreDto();
		// dto의 storeNum과 session의 email을 담아
		sDto.setNum(dto.getStoreNum());
		sDto.setOwner(email);
		
		Map<String, Object> map=new HashMap<>();
		if(dao.deleteMenu(dto) == 1) {
			map.put("isDeleted", true);
		} else {
			map.put("isDeleted", false);
		}
		
		return map;
	}
	
	// 해당 매장의 메뉴를 best로 설정 및 취소하는 method
	@Override
	public Map<String, Object> bestOnOff(String email, MenuDto dto) {
		// StoreDto를 만들어 전달받은 매장의 번호와 접속 email data를 넣어
		StoreDto sDto = new StoreDto();
		sDto.setNum(dto.getStoreNum());
		sDto.setOwner(email);
		
		Map<String, Object> map=new HashMap<>();
		// DB에 best로 설정된 매장의 개수를 가져와서
		int bestCount = dao.bestCount(sDto);
		// best 메뉴가 4개인지 여부를 기본적으로 false로 설정 후
		boolean isFour = false;
		// best 메뉴가 4개인데 전달받은 data가 yes일 경우 (4개에서 못늘림)
		if(bestCount == 4 && dto.getBest().equals("yes")) {
			isFour = true;
			// best 메뉴가 4개지만 전달받은 data가 no 인 경우 (4개에서 줄이기)
		} else if(bestCount == 4 && dto.getBest().equals("no")){
			isFour = false;
			dao.bestOnOff(dto);
			// best 메뉴가 4개 미만인 경우 (늘리거나 줄일 수 있음)
		} else if(bestCount < 4) {
			isFour = false;
			dao.bestOnOff(dto);
		}

		// best 메뉴가 4개인지 여부에 따라 다르게 return
		if(isFour) {
			// 4개면 못바꾸게 false return
			map.put("isSwitched", false);
		} else {
			map.put("isSwitched", true);
		}
		
		return map;
	}
}
