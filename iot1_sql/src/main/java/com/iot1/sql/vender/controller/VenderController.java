package com.iot1.sql.vender.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@RequestMapping(value="/vender/combo", method=RequestMethod.GET)
	public String getVenderInfoCombo(Model model){
		List<VenderInfo> viList = vs.getVenderInfoCombo();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		
		for(VenderInfo vi : viList){
			Map<String, Object> hm = new HashMap<String, Object>();
			hm.put("value", vi.getViNum());
			hm.put("text", vi.getViName());
			result.add(hm);
		}
		model.addAttribute("vender", result);
		return "goods/goods_list";
	}
	
	@RequestMapping(value="/vender/create", method=RequestMethod.POST)
	public @ResponseBody List<VenderInfo> saveVenderInfoList(@RequestBody VenderInfo[] venderList){
		for(VenderInfo vi : venderList){
			System.out.println(vi);
		}
		return null;
	}
}
