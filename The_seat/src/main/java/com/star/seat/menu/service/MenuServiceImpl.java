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
	public void addCategory(StoreDto dto) {
		// 해당 매장에 해당하는 DB 번호를 받아서 dto에 넣고
		
		// DB에서 해당 번호의 정보를 받아옴.
		StoreDto myDto=sDao.getMyStore_num(dto);
		
		// 만약 DB에 매장 tag 정보가 없다면
		if(myDto.getCategory()==null) {
			// 이스터 에그를 추가해주고
			myDto.setCategory("easter egg");
		}
		
		// DB의 내용을 , 로 구분해서 String array로 만들어주고
		String[] categories=myDto.getCategory().split(",");
		// 새로운 array를 만들어서 거기에 하나씩 담아줌.
		List<String> list=new ArrayList<>();
		for(int i=0; i<categories.length; i++) {
			list.add(categories[i]);
		}
		
		// 입력한 tag의 정보를 읽어서
		String newCategory=dto.getCategory();

		// array에 담아준 다음
		list.add(newCategory);
		// array 각 성분이 , 로 구분된 String으로 바꿔서
		String strList=String.join(",", list);
		
		// DB에서 받아온 dto에 넣은 다음에
		myDto.setCategory(strList);
		// dto를 넣어서 update
		dao.addCategory(myDto);
	}
	
	// 매장 메뉴의 카테고리를 삭제하는 method
	@Override
	public void deleteCategory(StoreDto dto) {
		// 해당 매장에 해당하는 DB 번호를 받아서 dto에 넣고
		
		// DB에서 해당 번호의 정보를 받아옴.
		StoreDto myDto=sDao.getMyStore_num(dto);
		
		// DB의 내용을 , 로 구분해서 String array로 만들어주고
		String[] categories=myDto.getCategory().split(",");
		// 새로운 array를 만들어서 거기에 하나씩 담아줌.
		List<String> list=new ArrayList<>();
		for(int i=0; i<categories.length; i++) {
			list.add(categories[i]);
		}
		
		// 입력한 tag의 정보를 읽어서
		String category=dto.getCategory();
		// array에서 없앤다음
		list.remove(list.indexOf(category));

		// array 각 성분이 , 로 구분된 String으로 바꿔서
		String strList=String.join(",", list);
		// DB에서 받아온 dto에 넣은 다음에
		myDto.setCategory(strList);
		// dto를 넣어서 update
		dao.deleteCategory(myDto);
	}
	
	// 해당 매장의 메뉴 정보를 추가하는 method
	@Override
	public void addMenu(int num, MenuDto dto, HttpServletRequest request) {
		
		StoreDto sDto=new StoreDto();
		sDto.setNum(num);
		sDto=sDao.getMyStore_num(sDto);
		
		dto.setStoreNum(num);
		dto.setStoreName(sDto.getStoreName());
		
		// 파일을 저장할 실제 경로 얻어오기
		String realPath=request.getServletContext().getRealPath("/upload");
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
		
		dto.setMenuImage("/upload/"+saveImageName);
		
		dao.addMenu(dto);
	}
	
	// 해당 매장의 메뉴 정보를 삭제하는 method
	public void deleteMenu(MenuDto dto) {
		dao.deleteMenu(dto);
	}
	
	// 해당 매장의 메뉴를 best로 설정 및 취소하는 method
	@Override
	public boolean bestOnOff(MenuDto dto, HttpServletRequest request) {
		String email=(String)request.getSession().getAttribute("email");
		StoreDto sDto=new StoreDto();
		int storeNum=Integer.parseInt(request.getParameter("storeNum"));
		String storeName=request.getParameter("storeName");
		sDto.setNum(storeNum);
		sDto.setStoreName(storeName);
		sDto.setOwner(email);
		
		int bestCount=(dao.bestCount(sDto));
		boolean beFour=false;
		if(bestCount==4 && dto.getBest().equals("yes")) {
			beFour=true;
		} else if(bestCount==4 && dto.getBest().equals("no")){
			beFour=false;
			dao.bestOnOff(dto);
		} else if(bestCount<4) {
			dao.bestOnOff(dto);
			beFour=false;
		}
		
		return beFour;
	}
}
