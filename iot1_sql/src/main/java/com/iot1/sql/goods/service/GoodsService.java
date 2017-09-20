package com.iot1.sql.goods.service;

import java.util.List;

import com.iot1.sql.goods.dto.GoodsInfo;

public interface GoodsService {

	public GoodsInfo getGoodsInfo(GoodsInfo gi);
	
	public List<GoodsInfo> getGoodsInfoList(GoodsInfo gi);
	
	public int insertGoods(GoodsInfo gi);
	
	public int insertGoodsList(GoodsInfo[] giList);
	
	public int updateGoods(GoodsInfo gi);
	
	public int updateGoodsList(GoodsInfo[] giList);
	
	public int deleteGoods(GoodsInfo gi);
	
	public int deleteGoodsList(GoodsInfo[] giList);
	
	
}
