package com.iot1.sql.user.dao.impl;

import java.util.List;


import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;


import com.iot1.sql.user.dao.UserDao;
import com.iot1.sql.user.dao.dto.UserInfo;


@Repository
public class UserDaoImpl extends SqlSessionDaoSupport implements UserDao {
	//SqlSessionDaoSupport -> resources에서 db-content.xml에서 
	//bean id="sqlSessionFactory" 가르킨다.
	@Override
	public UserInfo selectUser(UserInfo ui){
		return this.getSqlSession().selectOne("userInfo.SELECT_USER", ui);
		//파라메터로 받은 ui는 클래스가 UserInfo 임으로 user_sql.xml에서 parameterType="user" 받는타입을 user로 쓰는것이다.
	}

	@Override
	public List<UserInfo> selectUserList(UserInfo ui) {
		return this.getSqlSession().selectList("userInfo.SELECT_USER_LIST", ui);
	}

	@Override
	public int insertUser(UserInfo ui) {
		return this.getSqlSession().insert("userInfo.INSERT_USER", ui);
	}

	@Override
	public int updateUser(UserInfo ui) {
		return this.getSqlSession().update("userInfo.UPDATE_USER", ui);
	}

	@Override
	public int deleteUser(UserInfo ui) {
		return this.getSqlSession().delete("userInfo.DELETE_USER", ui);
	}

	
	
}
