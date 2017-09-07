package com.iot1.sql.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot1.sql.goods.dao.GoodsDAO;
import com.iot1.sql.goods.dto.GoodsInfo;

@Service
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsDAO gd;
	
	@Override
	public GoodsInfo getGoodsInfo(GoodsInfo gi) {
		
		return gd.selectGoodsInfo(gi);
	}

	@Override
	public List<GoodsInfo> getGoodsInfoList(GoodsInfo gi) {
		
		return gd.selectGoodsInfoList(gi);
	}

	@Override
	public int insertGoodsList(GoodsInfo[] giList) {
		int cnt = 0;
		for(GoodsInfo gi : giList){
			cnt += gd.insertGoods(gi);
		}
		return cnt;
	}

	@Override
	public int insertGoods(GoodsInfo gi) {	
		
		return gd.insertGoods(gi);
	}

	@Override
	public int updateGoodsList(GoodsInfo[] giList) {
		int cnt = 0;
		for(GoodsInfo gi : giList){
			cnt += gd.updateGoods(gi);
		}
		return cnt;
	}
	
	@Override
	public int updateGoods(GoodsInfo gi) {
		
		return gd.updateGoods(gi);
	}
	
	@Override
	public int deleteGoodsList(GoodsInfo[] giList) {
		int cnt = 0;
		for(GoodsInfo gi : giList){
			cnt += gd.deleteGoods(gi);
		}
		return cnt;
	}

	@Override
	public int deleteGoods(GoodsInfo gi) {
		
		return gd.updateGoods(gi);
	}

	
}
