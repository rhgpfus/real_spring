package com.iot1.sql.vender.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.iot1.sql.vender.dto.VenderInfo;

@Repository
public class VenderDAOImpl extends SqlSessionDaoSupport implements VenderDAO{

	@Override
	public VenderInfo selectVenderInfo(VenderInfo vi) {
		
		return this.getSqlSession().selectOne("venderInfo.SELECT_VENDER", vi);
	}

	@Override
	public List<VenderInfo> selectVenderInfoList(VenderInfo vi) {
		
		return this.getSqlSession().selectList("venderInfo.SELECT_VENDER", vi);
	}

	@Override
	public List<VenderInfo> selectVenderInfoCombo() {
		
		return this.getSqlSession().selectList("venderInfo.SELECT_VENDER_COMBO");
	}

	
}
