package com.star.seat.users.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.star.seat.users.dto.UsersDto;

@Repository
public class UsersDaoImpl implements UsersDao {
	
	@Autowired
	private SqlSession session;
	
	//user 추가
	@Override
	public int insert(UsersDto dto) {
		return session.insert("users.insert", dto);
	}
	//user 정보 가져오기
	@Override
	public UsersDto getData(String email) {
		return session.selectOne("users.getData", email);
	}
	//user 비밀번호 변경
	@Override
	public void updatePwd(UsersDto dto) {
		session.update("users.pwdUpdate", dto);
	}
	//user 정보 변경
	@Override
	public void update(UsersDto dto) {
		session.update("users.update", dto);
	}
	//user 삭제
	@Override
	public int delete(String email) {
		return session.delete("users.delete", email);
	}
	@Override
	public boolean isExist(String inputEmail) {
		//인자로 전달 받은 아이디가 존재 하는지 select 해 본다.
		String email=session.selectOne("users.isExist", inputEmail);
		if(email==null) {
			return false;
		}else {
			return true;
		}
	}
}
