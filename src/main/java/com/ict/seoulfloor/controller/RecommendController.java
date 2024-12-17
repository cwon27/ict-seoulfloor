package com.ict.seoulfloor.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ict.seoulfloor.service.RecommendService;
import com.ict.seoulfloor.vo.DataVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/recommend")
public class RecommendController {
	@Autowired
	RecommendService service;
	ModelAndView mav = null;
	
	@GetMapping("/recommendpage")
	public ModelAndView recommendpPage() {
		mav = new ModelAndView();
		mav.setViewName("/recommend/recommendPage");
		
		return mav;
	}
	@GetMapping("/showlist")
	public List<DataVO> showlist(@RequestParam Map<String, String> params) {
		// System.out.println("수신한 데이터: " + params);
		// log.info(service.listshow(params).toString());
		List<DataVO> resultlist = service.listshow(params);
		
		return resultlist;
	}
}
