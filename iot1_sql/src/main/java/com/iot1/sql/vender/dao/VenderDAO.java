package com.iot1.sql.vender.dao;

import java.util.List;

import com.iot1.sql.vender.dto.VenderInfo;

public interface VenderDAO {

	public VenderInfo selectVenderInfo(VenderInfo vi);
	
	public List<VenderInfo> selectVenderInfoList(VenderInfo vi);
	
	public List<VenderInfo> selectVenderInfoCombo();
	
	public int insertVender(VenderInfo vi);
	
	public int updateVender(VenderInfo vi);
	
	public int deleteVender(VenderInfo vi);
}
