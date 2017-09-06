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

	
}
