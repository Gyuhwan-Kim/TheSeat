package com.star.seat.users.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.users.dao.UsersDao;
import com.star.seat.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired
	private UsersDao dao;
	
	@Override
	public Map<String, Object> addUser(UsersDto dto) {
		//사용자가 입력한 비밀 번호를 읽어와서 
		String pwd=dto.getPwd();
		//암호화 한 후에 
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
		String encodedPwd=encoder.encode(pwd);
		//dto 에 다시 넣어준다.
		dto.setPwd(encodedPwd);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(dao.insert(dto)==1) {
			map.put("isSignup", true);
		} else {
			map.put("isSignup", false);
		}
		
		return map;
	}

	@Override
	public Map<String, Object> loginProcess(UsersDto dto) {
		//입력한 정보가 맞는여부
		boolean isValid = false;
		boolean isExist = true;

		//1. 로그인 폼에 입력한 아이디를 이용해서 해당 정보를 select 해 본다. 
		UsersDto result=dao.getData(dto.getEmail());
		if(result != null) {//만일 존재하는 아이디 라면
			//비밀번호가 일치하는지 확인한다.
			String encodedPwd=result.getPwd(); //DB 에 저장된 암호화된 비밀번호 
			String inputPwd=dto.getPwd(); //로그인폼에 입력한 비밀번호
			//Bcrypt 클래스의 static 메소드를 이용해서 일치 여부를 얻어낸다.
			isValid=BCrypt.checkpw(inputPwd, encodedPwd);
		} else {
			isExist = false;
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("result",result);
		map.put("isValid", isValid);
		map.put("isExist", isExist);
		
		return map;
	}

	@Override
	public UsersDto getInfo(String email) {

		//DB 에서 회원 정보를 얻어온다.
		return dao.getData(email);	
	}
	
	@Override
	public Map<String, Object> getData(String email) {
		//DB 에서 회원 정보를 얻어와서 
		UsersDto dto=dao.getData(email);
		
		// Map 객체에 담아준다.
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dto", dto);
		
		return map;
	}

	@Override
	public Map<String, Object> updateUserPwd(String email, UsersDto dto) {
		//DB 에 저장된 회원정보 얻어오기
		UsersDto resultDto=dao.getData(email);
		//DB 에 저장된 암호화된 비밀 번호
		String encodedPwd=resultDto.getPwd();
		//클라이언트가 입력한 비밀번호
		String inputPwd=dto.getPwd();
		//두 비밀번호가 일치하는지 확인
		boolean isValid=BCrypt.checkpw(inputPwd, encodedPwd);
		//만일 일치 한다면
		if(isValid) {
			//새로운 비밀번호를 암호화 한다.
			BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
			String encodedNewPwd=encoder.encode(dto.getNewPwd());
			//암호화된 비밀번호를 dto 에 다시 넣어준다.
			dto.setNewPwd(encodedNewPwd);
			//dto 에 로그인된 아이디도 넣어준다.
			dto.setEmail(email);
			//dao 를 이용해서 DB 에 수정 반영한다.
			dao.updatePwd(dto);
		}
		Map<String, Object> map=new HashMap<String, Object>();
		//작업의 성공여부를 Map 객체에 담아 놓는다(결국 HttpServletRequest 에 담긴다)
		map.put("isSuccess", isValid);

		return map;
	}

	@Override
	public Map<String, Object> saveProfileImage(String realPath, MultipartFile mFile) {
		//업로드된 파일에 대한 정보를 MultipartFile 객체를 이용해서 얻어낼수 있다.	
		
		//원본 파일명
		String orgFileName=mFile.getOriginalFilename();
		//upload 폴더에 저장할 파일명을 직접구성한다.
		// 1234123424343xxx.jpg
		String saveFileName=System.currentTimeMillis()+orgFileName;
		
		// upload 폴더가 존재하지 않을경우 만들기 위한 File 객체 생성
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

	@Override
	public Map<String, Object> updateUser(UsersDto dto, String email) {
		//UsersDto 에 아이디도 담아 주고
		dto.setEmail(email);
		
		Map<String, Object> map = new HashMap<>();
		//UsersDao 를 이용해서 수정 반영한다.
		if(dao.update(dto)==1) {
			map.put("isUpdated", true);
		} else {
			map.put("isUpdated", false);
		}
		
		return map;
	}

	@Override
	public Map<String, Object> deleteUser(HttpSession session) {
		//로그인된 아이디를 얻어와서 
		String email=(String)session.getAttribute("email");
		
		Map<String, Object> map=new HashMap<String, Object>();
		//해당 정보를 DB 에서 삭제하고 (삭제되면 1)
		if(dao.delete(email)==1) {
			//로그아웃 처리도 한다.
			session.removeAttribute("email");
			//ModelAndView 객체에 탈퇴한 회원의 아이디를 담아준다.
			map.put("email", email);
			map.put("isDeleted", true);
		} else {
			// 삭제 안되면 0
			map.put("isDeleted", false);
		}
		return map;
	}

	@Override
	public Map<String, Object> isExistEmail(String inputEmail) {
		//Map 객체를 생성해서 
		Map<String, Object> map=new HashMap<String, Object>();
		//isExist 라는 키값으로 아이디가 존재하는지 여부를 담고 
		map.put("isExist", dao.isExist(inputEmail));
		//Map 객체를 리턴해 준다. 
		return map;
	}

	@Override
	public Map<String, Object> getOrderData(String email) {
		//DB 에서 회원 정보를 얻어와서 
		UsersDto dto=dao.getData(email);
		
		//Map 객체에 담아준다.
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dto", dto);
		
		return map;
	}
}
