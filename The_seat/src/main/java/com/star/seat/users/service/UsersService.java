package com.star.seat.users.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.star.seat.users.dto.UsersDto;


public interface UsersService {
	
	public Map<String, Object> isExistEmail(String inputEmail);
	public Map<String, Object> addUser(UsersDto dto);
	public Map<String, Object> loginProcess(UsersDto dto);
	public UsersDto getInfo(String email);
	public Map<String, Object> getData(HttpSession session);
	public Map<String, Object> getOrderData(HttpServletRequest request);
	public Map<String, Object> updateUserPwd(HttpSession session, UsersDto dto);
	public Map<String, Object> saveProfileImage(HttpServletRequest request, MultipartFile mFile);
	public Map<String, Object> updateUser(UsersDto dto, HttpSession session);
	public Map<String, Object> deleteUser(HttpSession session);
}
