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
	public String loginform() {

		return "users/loginform";
	}
	
	//로그인 요청 처리
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxLogin( UsersDto dto, HttpSession session) {
		
		Map<String, Object> login = service.loginProcess(dto, session);
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url","${pageContext.request.contextPath}/main.do");
		map.put("login", login);
		
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
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSignup", service.addUser(dto));
		
		return map;
	}
	
	//회원 탈퇴 요청 처리
	@RequestMapping("/users/delete")
	@ResponseBody
	public Map<String, Object> Delete(HttpSession session, 
			HttpServletRequest request) {
		
		List<StoreDto> list= sService.getMyStores(request, session);
		for(StoreDto dto:list) {
			StoreDto sDto = new StoreDto();
			sDto.setNum(dto.getNum());
			sService.deleteStore(sDto, request);
		}
		OrderDto oDto = new OrderDto();
		oDto.setEmail((String)session.getAttribute("email"));
		order_service.deleteEmailOrder(oDto);
		
		// 회원탈퇴한 email 정보를 전달 
		return service.deleteUser(session);
	}
	
	//개인정보 수정 반영 요청 처리
	@RequestMapping(value = "/users/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> Update(UsersDto dto, HttpSession session,
			HttpServletRequest request) {
		//서비스를 이용해서 개인정보를 수정하고 
		service.updateUser(dto, session);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isUpdate",true);
		return map;
	}
	
	//ajax 프로필 사진 업로드 요청처리
	@RequestMapping(value = "/users/ajax_profile_upload",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> AjaxProfileUpload(HttpServletRequest request,
			@RequestParam MultipartFile image){
		
		//서비스를 이용해서 이미지를 upload 폴더에 저장하고 리턴되는 Map 을 리턴해서 json 문자열 응답하기
		return service.saveProfileImage(request, image);
	}
	
	//비밀번호 변경
	@RequestMapping(value = "/users/pwd_update",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> PwdUpdate(UsersDto dto, 
			 HttpSession session) {
		
		return service.updateUserPwd(session, dto);
	}
	
	//로그인된 회원정보와 함께 info 페이지로 이동
	@RequestMapping("/users/info")
	public ModelAndView Info(ModelAndView mView,HttpServletRequest request, 
			HttpSession session) {
		
		//접속중인 회원의 회원정보 가져가기
		service.getInfo(mView, session);
		//접속중인 회원이 갖은 매장 리스트 가져가기
		sService.getMyStores(request, session);
		//접속중인 회원의 주문내역 가져가기
		order_service.getList(mView, request, session);
		
		mView.setViewName("users/info");
		return mView;
	}
	
	//로그인된 정보를 이용하여 회원정보 가져오기
	@RequestMapping("/users/getData")
	@ResponseBody
	public Map<String, Object> getUser(HttpSession session) {
		
		return service.getData(session);
	}
	
	//주문 정보의 email을 이용하여 회원정보 가져오기
	@RequestMapping(value = "/users/getOrderData",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOrderUser(HttpServletRequest request) {
		return service.getOrderData(request);
	}
	
	//로그아웃
	@RequestMapping("/users/logout")
	public ModelAndView logout(ModelAndView mView, HttpSession session) {
		//세션에서 id 라는 키값으로 저장된 값 삭제 
		
		session.removeAttribute("email");
		mView.setViewName("redirect:/main.do?area=&keyword=");
		return mView;
	}
}
