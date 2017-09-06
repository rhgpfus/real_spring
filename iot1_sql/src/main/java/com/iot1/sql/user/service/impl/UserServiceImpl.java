package com.iot1.sql.user.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot1.sql.user.dao.UserDao;
import com.iot1.sql.user.dao.dto.UserInfo;
import com.iot1.sql.user.service.UserService;


@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;

	@Override
	public UserInfo login(UserInfo ui) {
		UserInfo mainUI = userDao.selectUser(ui);
		//UserInfo ui 는 화면에서 넘긴 유저.
		//UserInfo mainUI 는 데이터베이스에 있는 유저.
		if(mainUI!=null && mainUI.getUserPwd().equals(ui.getUserPwd())){
			return mainUI;
		}
		return null;
	}

	@Override
	public UserInfo selectUser(UserInfo ui) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserInfo> selectUserList(UserInfo ui) {
		return userDao.selectUserList(ui);
	}

	@Override
	public int insertUser(UserInfo ui) {
		
		return 0;
	}

	@Override
	public int updateUser(UserInfo ui) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteUser(UserInfo ui) {
		// TODO Auto-generated method stub
		return 0;
	}

	
}
