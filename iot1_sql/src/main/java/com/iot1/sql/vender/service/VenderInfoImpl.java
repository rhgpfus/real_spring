package com.iot1.sql.vender.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot1.sql.vender.dao.VenderDAO;
import com.iot1.sql.vender.dto.VenderInfo;

@Service
public class VenderInfoImpl implements VenrderService{

	@Autowired
	private VenderDAO vd;
	
	@Override
	public VenderInfo getVenderInfo(VenderInfo vi) {
		
		return vd.selectVenderInfo(vi);
	}

	@Override
	public List<VenderInfo> getVenderInfoList(VenderInfo vi) {
		
		return vd.selectVenderInfoList(vi);
	}

}
