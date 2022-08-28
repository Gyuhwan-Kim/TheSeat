package com.star.seat.users.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.order.dto.OrderDto;
import com.star.seat.order.service.OrderService;
import com.star.seat.store.dto.StoreDto;
import com.star.seat.store.service.StoreService;
import com.star.seat.users.dto.UsersDto;
import com.star.seat.users.service.UsersService;


@Controller
public class UsersController {
	
	
	@Autowired
	private UsersService service;
	
	@Autowired
	private StoreService sService;
	
	@Autowired
	private OrderService order_service;
	
	//로그인 폼 요청 처리
	@RequestMapping("/users/loginform")
	public ModelAndView loginform(HttpServletRequest request) {
		String redirect = request.getHeader("referer");

		ModelAndView mView = new ModelAndView();
		mView.addObject("redirect", redirect);
		mView.setViewName("users/loginform");
		
		return mView;
	}
	
	//로그인 요청 처리
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxLogin(@RequestParam String redirect, UsersDto dto, HttpSession session) {
		Map<String, Object> map = service.loginProcess(dto);
		if(redirect.contains("store") || redirect.contains("info") || redirect.contains("main")) {
			map.put("redirect", redirect);
		}
		
		if((boolean)map.get("isValid")) {
			session.setAttribute("email", dto.getEmail());
		}
		
		return map;
	}
	
	//아이디 중복 확인을 해서 json 문자열을 리턴해주는 메소드 
	@RequestMapping("/users/checkemail")
	@ResponseBody
	public Map<String, Object> checkEmail(@RequestParam String inputEmail){
		//UsersService 가 리턴해주는 Map 을 리턴해서 json 문자열을 응답한다. 
		return service.isExistEmail(inputEmail);
	}

	//회원 가입 요청 처리 ( post 방식 요청은 요청 method 를 명시하는것이 좋다.
	@RequestMapping(value = "/users/signup", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> signup(UsersDto dto) {
		
		return service.addUser(dto);
	}
	
	//회원 탈퇴 요청 처리
	@RequestMapping("/users/delete")
	@ResponseBody
	public Map<String, Object> delete(StoreDto dto, HttpSession session, HttpServletRequest request) {
		//로그인된 아이디를 얻어와서 
		String email=(String)session.getAttribute("email");
		
		Map<String, Object> map = service.deleteUser(email);
		if((boolean)map.get("isDeleted")) {
			//로그아웃 처리도 한다.
			session.removeAttribute("email");
		}
		
		// 회원탈퇴한 email 정보를 전달 
		return map;
	}
	
	//개인정보 수정 반영 요청 처리
	@RequestMapping(value = "/users/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(UsersDto dto, HttpSession session) {
		//수정할 회원의 아이디
		String email=(String)session.getAttribute("email");
		
		//서비스를 이용해서 개인정보를 수정하고 성공 여부까지 담아서 return
		return service.updateUser(dto, email);
	}
	
	//ajax 프로필 사진 업로드 요청처리
	@RequestMapping(value = "/users/ajax_profile_upload", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxProfileUpload(HttpServletRequest request, @RequestParam MultipartFile image){
		// webapp/upload 폴더까지의 실제 경로 얻어내기 
		String realPath=request.getServletContext().getRealPath("/upload");
		
		//서비스를 이용해서 이미지를 upload 폴더에 저장하고 리턴되는 Map 을 리턴해서 json 문자열 응답하기
		return service.saveProfileImage(realPath, image);
	}
	
	//비밀번호 변경
	@RequestMapping(value = "/users/pwd_update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> pwdUpdate(UsersDto dto, HttpSession session) {
		//세션 영역에서 로그인된 아이디 읽어오기
		String email=(String)session.getAttribute("email");
		
		Map<String, Object> map = service.updateUserPwd(email, dto);
		if((boolean)map.get("isValid")) {
			//로그아웃 처리
			session.removeAttribute("email");
		}
		
		return map;
	}
	
	//로그인된 회원정보와 함께 info 페이지로 이동
	@RequestMapping("/users/info")
	public ModelAndView info(ModelAndView mView, HttpServletRequest request, 
			HttpSession session) {
		//로그인된 아이디를 읽어온다. 
		String email=(String)session.getAttribute("email");
		//페이지 번호가 파라미터로 전달되는지 읽는다.
		String strPageNum = request.getParameter("pageNum");
		
		//접속중인 회원의 회원정보를 ModelAndView 객체에 담아준다.
		mView.addObject("dto", service.getInfo(email));
		
		//접속중인 회원이 가진 매장 리스트의 수를 담아준다.
		mView.addObject("myStoreCount", sService.getMyStores(email).size());
		
		//접속중인 회원의 주문내역 가져가기
		mView.addObject("orderData", order_service.getList(strPageNum, email));
		
		mView.setViewName("users/info");

		return mView;
	}
	
	//로그인된 정보를 이용하여 회원정보 가져오기
	@RequestMapping("/users/getData")
	@ResponseBody
	public Map<String, Object> getUser(HttpSession session) {
		//로그인된 아이디를 읽어온다. 
		String email=(String)session.getAttribute("email");
		
		return service.getData(email);
	}
	
	//주문 정보의 email을 이용하여 회원정보 가져오기
	@RequestMapping(value = "/users/getOrderData", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOrderUser(HttpServletRequest request) {
		//로그인된 아이디를 읽어온다. 
		String email=(String)request.getParameter("email");
		
		return service.getOrderData(email);
	}
	
	//로그아웃
	@RequestMapping("/users/logout")
	public String logout(HttpSession session, HttpServletRequest request) {
		//세션에서 id 라는 키값으로 저장된 값 삭제 
		session.removeAttribute("email");
		String path = request.getHeader("referer");

		if(path.contains("users") || path.contains("manage")) {
			return "redirect:/main.do?area=&keyword=";
		} else {
			// request 객체의 getHeader("referer") method를 쓰면 기존 요청 url을 알 수 있다.
			return "redirect:"+request.getHeader("referer");
		}
	}
}
