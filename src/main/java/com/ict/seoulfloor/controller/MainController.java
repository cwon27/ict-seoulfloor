package com.ict.seoulfloor.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ict.seoulfloor.service.MainService;
import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.EventVO;
import com.mysql.cj.xdevapi.JsonArray;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/main")
public class MainController {
   @Autowired
   MainService service;
   ModelAndView mav = null;
   
   //병조
   @GetMapping("/calpage")
   public ModelAndView calpage() {
      mav = new ModelAndView();
      // 오늘 날짜 구하기
      LocalDate now = LocalDate.now();
      LocalDate start = now.minusMonths(1).withDayOfMonth(1);
      LocalDate end = now.plusMonths(2).withDayOfMonth(1);
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
      String startDate = start.format(formatter);
      String endDate = end.format(formatter);
        
      List<Map<String, Object>> event = service.calSelect(startDate, endDate);
      JSONArray eventarray = new JSONArray();
      for(Map m : event) {
         JSONObject obj = new JSONObject();
         obj.put("start", m.get("start"));
         obj.put("title", m.get("title")+"개");
         obj.put("color", "rgba(255,255,255,0)");
         obj.put("textColor", "black");
         eventarray.put(obj);
      }
      // log.info("1," + eventarray.toString());
      mav.addObject("event", eventarray);
      // List<Map<String, Object>> events = service.calSelect(startDate, endDate);
      //System.out.println(event.toString());
      // mav.addObject("events", events);
      mav.setViewName("/main/calPage");
      return mav;
   }
   @GetMapping("/getCal")
   public List<DataVO> getCalendar(@RequestParam String dateStr) {
       // dateStr을 받아서 처리
        //System.out.println("Received dateStr: " + dateStr);
       // System.out.println("test" + service.getDateList(dateStr));
       List<DataVO> resultlist = service.getDateList(dateStr);
       // 처리 후 결과 반환
       return resultlist;
   }
   //병조 끝
   
   //정
   @GetMapping("/event")
	public ModelAndView event() {
	    mav = new ModelAndView();
		mav.addObject("list", service.eventList());
		mav.setViewName("main/event_view");
		return mav;
	}
	
   @GetMapping("/page/{no}")
	public ModelAndView page(@PathVariable("no") int no) {
	    ModelAndView mav = new ModelAndView();

	    service.eventhi(no);
	    EventVO event = service.eventView(no);
	    System.out.println(event);
	    mav.addObject("view", event);
	    //mav.addObject("view", service.eventView(no)); //
	    mav.setViewName("main/page");
	    return mav;
	}
   @GetMapping("/ev_list")/*받는 방식*/
   public List<EventVO> event_a(String sort) {//@RequestParam("sort")
      log.info(sort);
      
      return service.getEventsSortedBy(sort);
   }
	//정 끝
	
	//채원
	@GetMapping("/mainPage")
	public ModelAndView mainPage() {
		//poster
		List<DataVO> list = service.mainSelectRecord();
		log.info(list.toString());
		
		//review
		List<CommentVO> review_list = service.mainReviewSelect();
		
		mav = new ModelAndView();
		mav.addObject("list",list);
		mav.addObject("review_list", review_list);
		mav.setViewName("main/mainPage");
		
		return mav;
	}
	//채원 끝
}