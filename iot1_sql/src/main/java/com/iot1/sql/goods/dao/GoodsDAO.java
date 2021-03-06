package com.iot1.sql.goods.dao;

import java.util.List;

import com.iot1.sql.goods.dto.GoodsInfo;

public interface GoodsDAO {

	public GoodsInfo selectGoodsInfo(GoodsInfo gi);
	
	public List<GoodsInfo> selectGoodsInfoList(GoodsInfo gi);
	
	public int insertGoods(GoodsInfo gi);
	
	public int updateGoods(GoodsInfo gi);
	
	public int deleteGoods(GoodsInfo gi);
	
	
}
