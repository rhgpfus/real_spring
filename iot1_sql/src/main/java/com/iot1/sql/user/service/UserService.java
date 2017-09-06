package com.iot1.sql.user.service;

import java.util.List;
import java.util.Map;

import com.iot1.sql.user.dao.dto.UserInfo;

public interface UserService {

	public UserInfo login(UserInfo ui);
	
	public UserInfo selectUser(UserInfo ui);
	
	public List<UserInfo> selectUserList(UserInfo ui);
	
	public int insertUser(UserInfo ui);
	
	public int updateUser(UserInfo ui);
	
	public int deleteUser(UserInfo ui);
}
