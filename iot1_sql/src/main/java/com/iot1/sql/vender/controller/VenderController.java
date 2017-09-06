package com.iot1.sql.vender.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iot1.sql.vender.dto.VenderInfo;
import com.iot1.sql.vender.service.VenrderService;

@Controller
public class VenderController {

	@Autowired
	private VenrderService vs;
	
	@RequestMapping(value="/vender/list", method=RequestMethod.POST)
	public @ResponseBody List<VenderInfo> getVenderInfoList(VenderInfo vi){
		return vs.getVenderInfoList(vi);
	}
}
