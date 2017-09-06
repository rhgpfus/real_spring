package com.iot1.sql.goods.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.iot1.sql.goods.dto.GoodsInfo;

@Repository
public class GoodsDAOImpl extends SqlSessionDaoSupport implements GoodsDAO{

	@Override
	public GoodsInfo selectGoodsInfo(GoodsInfo gi) {
		
		return this.getSqlSession().selectOne("goodsInfo.SELECT_GODDS", gi);
	}

	@Override
	public List<GoodsInfo> selectGoodsInfoList(GoodsInfo gi) {
		
		return this.getSqlSession().selectList("goodsInfo.SELECT_GODDS", gi);
	}

}
