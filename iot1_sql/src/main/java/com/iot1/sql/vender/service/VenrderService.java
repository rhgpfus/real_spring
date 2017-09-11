package com.iot1.sql.vender.service;

import java.util.List;

import com.iot1.sql.vender.dto.VenderInfo;

public interface VenrderService {

	public VenderInfo getVenderInfo(VenderInfo vi);
	
	public List<VenderInfo> getVenderInfoList(VenderInfo vi);
	
	public List<VenderInfo> getVenderInfoCombo();
	
	public int insertVender(VenderInfo vi);
	
	public int insertVenderList(VenderInfo[] viList);
	
	public int updateVender(VenderInfo vi);
	
	public int updateVenderList(VenderInfo[] viList);
	
	public int deleteVender(VenderInfo vi);
	
	public int deleteVenderList(VenderInfo[] viList);
}
