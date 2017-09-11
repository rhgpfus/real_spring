package com.iot1.sql.vender.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot1.sql.vender.dao.VenderDAO;
import com.iot1.sql.vender.dto.VenderInfo;

@Service
public class VenrderServiceImpl implements VenrderService{

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

	@Override
	public List<VenderInfo> getVenderInfoCombo() {
		
		return vd.selectVenderInfoCombo();
	}

	@Override
	public int insertVender(VenderInfo vi) {
		
		return vd.insertVender(vi);
	}

	@Override
	public int insertVenderList(VenderInfo[] viList) {
		int cnt = 0;
		for(VenderInfo vi : viList){
			cnt += vd.insertVender(vi);
		}
		return cnt;
	}

	@Override
	public int updateVender(VenderInfo vi) {
		
		return vd.updateVender(vi);
	}

	@Override
	public int updateVenderList(VenderInfo[] viList) {
		int cnt = 0;
		for(VenderInfo vi : viList){
			cnt += vd.updateVender(vi);
		}
		return cnt;
	}

	@Override
	public int deleteVender(VenderInfo vi) {
		
		return vd.deleteVender(vi);
	}

	@Override
	public int deleteVenderList(VenderInfo[] viList) {
		int cnt = 0;
		for(VenderInfo vi : viList){
			cnt += vd.deleteVender(vi);
		}
		return cnt;
	}

}
