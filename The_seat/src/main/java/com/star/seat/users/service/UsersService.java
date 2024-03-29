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
	public Map<String, Object> getData(String email);
	public Map<String, Object> getOrderData(String email);
	public Map<String, Object> updateUserPwd(String email, UsersDto dto);
	public Map<String, Object> saveProfileImage(String realPath, MultipartFile mFile);
	public Map<String, Object> updateUser(UsersDto dto, String email);
	public Map<String, Object> deleteUser(String email);
}
