package com.playchoice.play.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playchoice.play.dto.PlayshowDTO;
import com.playchoice.play.service.PlayService;

/**
 * 연극 목록, 검색, 정보 열람, 예매
 */
@Controller
@RequestMapping("/play")
public class PlayController {
	
	@Autowired
	private PlayService service;
	
	private static final Logger logger = LoggerFactory.getLogger(PlayController.class);
	
	@RequestMapping(value="playlist", method=RequestMethod.GET)
	public void playListController(Model model) throws Exception {
		
		logger.info("list get............");
		System.out.println(service.playList().toString());
		model.addAttribute("list", service.playList());
	}
	
	@RequestMapping(value="playdetail", method=RequestMethod.GET)
	public void playDetail(@RequestParam("p_id") int p_id, Model model) throws Exception{
		model.addAttribute(service.playDetail(p_id));
	}
	
	@RequestMapping("checkSchedule")
	@ResponseBody
	public Object getSchedule(@RequestParam HashMap<String,Object> param) {
		System.out.println("컨트롤 왓다");
		List<Object> res = new ArrayList<Object>();
		res = service.viewCal(param);

		param.put("list", res);
		
		param.put("msg", "컨트롤 왓다리갓다리");
	
		System.out.println(param.get("list"));
		return param;
	}
	
}
