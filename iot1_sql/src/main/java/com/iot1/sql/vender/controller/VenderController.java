package com.iot1.sql.vender.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	public @ResponseBody List<VenderInfo> getVenderInfoList(@RequestBody VenderInfo vi){
		return vs.getVenderInfoList(vi);
	}
	
	@RequestMapping(value="/vender/combo", method=RequestMethod.GET)
	public String getVenderInfoCombo(Model model, HttpServletRequest request){
		List<VenderInfo> viList = vs.getVenderInfoCombo();
		
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		
		for(VenderInfo vi : viList){
			Map<String, Object> hm = new HashMap<String, Object>();
			hm.put("value", vi.getViNum());
			hm.put("text", vi.getViName());
			result.add(hm);
		}
		
		model.addAttribute("venders", result);
		String url = request.getParameter("url");
        if(url==null || url.equals("")){
        	url = "goods/goods_list";
        }
		return url;
	}
	
	@RequestMapping(value="/vender/create", method=RequestMethod.POST)
	public @ResponseBody List<VenderInfo> saveVenderInfoList(@RequestBody VenderInfo[] viList, VenderInfo vi){
		
		int result = vs.insertVenderList(viList);
		for(VenderInfo vi2 : viList){
			System.out.println(vi2);
			System.out.println(result);
		}
		return vs.getVenderInfoList(null);
	}
	
	@RequestMapping(value="/vender/update", method=RequestMethod.POST)
	public @ResponseBody List<VenderInfo> updateVenderInfoList(@RequestBody VenderInfo[] viList, VenderInfo vi){
		int result = vs.updateVenderList(viList);
		for(VenderInfo vi2 : viList){
			System.out.println(vi2);
			System.out.println(result);
		}
		return vs.getVenderInfoList(null);
	}
	
	@RequestMapping(value="/vender/delete", method=RequestMethod.POST)
	public @ResponseBody List<VenderInfo> deleteVenderInfoList(@RequestBody VenderInfo[] viList, VenderInfo vi){
		int result = vs.deleteVenderList(viList);
		for(VenderInfo vi2 : viList){
			System.out.println(vi2);
			System.out.println(result);
		}
		return vs.getVenderInfoList(null);
	}
}
