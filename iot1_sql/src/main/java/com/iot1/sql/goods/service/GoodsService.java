package com.iot1.sql.goods.service;

import java.util.List;

import com.iot1.sql.goods.dto.GoodsInfo;

public interface GoodsService {

	public GoodsInfo getGoodsInfo(GoodsInfo gi);
	
	public List<GoodsInfo> getGoodsInfoList(GoodsInfo gi);
	
	public int insertGoods(GoodsInfo giList);
	
	public int insertGoodsList(GoodsInfo[] giList);
	
	public int updateGoods(GoodsInfo giList);
	
	public int updateGoodsList(GoodsInfo[] giList);
	
	public int deleteGoods(GoodsInfo giList);
	
	public int deleteGoodsList(GoodsInfo[] giList);
	
	
}
