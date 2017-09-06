package com.iot1.sql.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iot1.sql.user.dao.dto.UserInfo;
import com.iot1.sql.user.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService us;
	
	@RequestMapping(value="/user/login", method=RequestMethod.GET)
	public String login(){
		return "user/login";
	}
	
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public @ResponseBody ModelMap login(HttpSession session, @RequestBody UserInfo ui, ModelMap mm){
		UserInfo mainUI = us.login(ui);
		if(mainUI!=null){
			session.setAttribute("user", mainUI);
			mm.put("msg", "로긴성공");
			mm.put("url", "/main");
		}else{
			mm.put("msg", "로긴실패");
			mm.put("url", "/user/login");
		}
		return mm;
	}
	
	@RequestMapping(value="/user/list", method=RequestMethod.POST)
	public @ResponseBody List<UserInfo> getUserList(HttpSession session, UserInfo ui, ModelMap mm){
		//@ResponseBody : JSON타입의 String으로 만든다.
		return us.selectUserList(ui);
	}
	
	
}
