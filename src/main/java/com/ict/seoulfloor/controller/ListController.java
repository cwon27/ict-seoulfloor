package com.ict.seoulfloor.controller;

import java.nio.charset.Charset;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import com.ict.seoulfloor.service.ListService;
import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.LikeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/list")
public class ListController {
	@Autowired
	ListService service;
	ModelAndView mav = null;

	   // 혜린 부분 ///////////////////////////////////////////////////////////////////////////////////////
	   
	   // 1. tradition
	   // 리스트 불러오기
	   @GetMapping("/traditionalList")
	   public ModelAndView getTradList() {
	      mav = new ModelAndView();
	      List<DataVO> dataList = service.getTradList();
	      mav.addObject("dataList", dataList);
	      mav.setViewName("list/traditionalList");
	      return mav;
	   }
	   
	   // 검색, 페이징, 정렬
	   @GetMapping("/search")
	    public Map<String, Object> searchLists(
	            @RequestParam(value = "keyword", required = false) String keyword,
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "pageSize", defaultValue = "12") int pageSize,
	            @RequestParam(value = "sort", defaultValue = "latest") String sort) { // sort 추가

	      System.out.println("Controller - 검색어: " + keyword + ", 페이지: " + page + ", 페이지 크기: " + pageSize + ", 정렬: " + sort);
	        
	       int totalRecords;
	        List<DataVO> results;

	        if (keyword == null || keyword.trim().isEmpty()) {
	            // 검색어가 없으면 전체 리스트 조회
	            totalRecords = service.getTotalCount(null);  // 전체 레코드 수
	            results = service.searchLists(null, page, pageSize, sort);  // 전체 리스트 조회
	            System.out.println("전체 레코드 수: " + totalRecords);
	        } else {
	            // 검색어가 있을 때
	            totalRecords = service.getTotalCount(keyword);  // 검색된 레코드 수
	            results = service.searchLists(keyword, page, pageSize, sort);  // 검색된 리스트 조회
	            System.out.println("검색된 레코드 수: " + totalRecords);
	        }
	        
	        System.out.println("검색 결과: " + results);
	        Map<String, Object> response = new HashMap<String, Object>();
	        response.put("totalRecords", totalRecords);
	        response.put("results", results);
	        return response;
	    }
	   
	   // 2. hip
	   
	   // 리스트 불러오기
	   @GetMapping("/hipList")
	   public ModelAndView getHipList() {
	      mav = new ModelAndView();
	      List<DataVO> dataList = service.getHipList();
	      mav.addObject("dataList", dataList);
	      mav.setViewName("list/hipList");
	      return mav;
	   }
	   
	   // 검색, 페이징, 정렬
	   @GetMapping("/searchHip")
	    public Map<String, Object> searchHipLists(
	            @RequestParam(value = "keyword", required = false) String keyword,
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "pageSize", defaultValue = "12") int pageSize,
	            @RequestParam(value = "sort", defaultValue = "latest") String sort) { // sort 추가

	      System.out.println("Controller - 검색어: " + keyword + ", 페이지: " + page + ", 페이지 크기: " + pageSize + ", 정렬: " + sort);
	        
	      int totalRecords;
	        List<DataVO> results;

	        if (keyword == null || keyword.trim().isEmpty()) {
	            // 검색어가 없으면 전체 리스트 조회
	            totalRecords = service.getTotalHipCount(null);  // 전체 레코드 수
	            results = service.searchHipLists(null, page, pageSize, sort);  // 전체 리스트 조회
	            System.out.println("전체 레코드 수: " + totalRecords);
	        } else {
	            // 검색어가 있을 때
	            totalRecords = service.getTotalHipCount(keyword);  // 검색된 레코드 수
	            results = service.searchHipLists(keyword, page, pageSize, sort);  // 검색된 리스트 조회
	            System.out.println("검색된 레코드 수: " + totalRecords);
	        }
	        
	        System.out.println("검색 결과: " + results);
	        Map<String, Object> response = new HashMap<String, Object>();
	        response.put("totalRecords", totalRecords);
	        response.put("results", results);
	        return response;
	    }
	   

	   // 혜린 부분 끝 ///////////////////////////////////////////////////////////////////////////////////////

	// 채원 부분
		// 상세페이지 view
		@GetMapping("/listView/{no}")
		public ModelAndView listView(@PathVariable("no") int no, HttpSession session) {
			String logId= (String)session.getAttribute("logId");//session에 있는 logId를 가저옴 
			
			service.hitCount(no,logId);
			DataVO detailView = service.listSelectOne(no);
			log.info(detailView.toString());

			mav = new ModelAndView();
			mav.addObject("vo", detailView);
			mav.setViewName("list/listView");

			return mav;
		}

		// 리뷰 write폼 view
		@GetMapping("/reWrite/{no}")
		public ModelAndView reWrite(@PathVariable("no") int Data_no, CommentVO vo) {
			DataVO reviewDetail = service.listSelectOne(Data_no);
			mav = new ModelAndView();
			mav.addObject("vo",reviewDetail);
			mav.setViewName("list/reWrite");
			return mav;
		}

		//리뷰 write(DB)
		@PostMapping("/reWriteOk") 
		public ResponseEntity<String> reWriteOk(CommentVO vo, HttpSession session) {  
			log.info(vo.toString());
			vo.setUserid((String)session.getAttribute("logId"));

		    int s = vo.getContent().indexOf("<img src=\""); 
		    int l = vo.getContent().indexOf("\">", s); 
		    String img = vo.getContent().substring(s+10,l); 
		    log.info("img=>"); 
		    log.info("img=>{}",img); 
		    vo.setThumb(img);
		    
		    int p = vo.getContent().indexOf("<p>"); 
		    int t = vo.getContent().indexOf("</p>", p);
		    String pTag = vo.getContent().substring(p+3,t);
		    
		    if(s>=0) {
		    	pTag = vo.getContent().substring(p+3, s);
		    }
		    log.info("pTag=>{}",pTag); 
		    vo.setContent_txt(pTag);
		    
		    
			log.info(vo.toString());
			
			String bodyTag = "";

			try {
		           int result = service.reviewInsert(vo);
		           log.info(vo.toString());
		           if(result!=1) {
		        	   bodyTag+="<script>";
		               bodyTag+="  alert('리뷰 등록을 실패했습니다.');";
		               bodyTag+="  history.back();";
		               bodyTag+="</script>";
		           }else {
		        	   bodyTag+="<script>";
		               bodyTag+="  alert('리뷰가 등록되었습니다.');";
		               bodyTag+="  window.open('', '_self').close();";
		               bodyTag+="  opener.location.href = '/seoulfloor/list/listView/"+vo.getData_no()+"'";
		               bodyTag+="</script>"; 
		           }
		        }catch(Exception e) {
		        	bodyTag+="<script>";
		            bodyTag+="  alert('리뷰 등록을 실패했습니다.');";
		            bodyTag+="  history.back();";
		            bodyTag+="</script>";
		        }
			HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(new MediaType("text","html", Charset.forName("UTF-8")));
	        ResponseEntity<String> entity = new ResponseEntity<String>(bodyTag, headers, HttpStatus.OK);

	        return entity;
		}
		
		//리뷰 리스트 보여주기
		@GetMapping("/reviewList")
		public List<CommentVO> reviewList(int Data_no){
			return service.reviewSelectList(Data_no);
		}
		
		//리뷰 별점 평균 보여주기
		@GetMapping("/reviewGradeAvg")
		public double reviewGradeAvg(int Data_no, CommentVO vo){
			CommentVO vo1 = service.reviewGradeAvg(Data_no);
			double grade_avg = vo1.getGrade_avg();
			 
			return grade_avg;
		}
		
		// 리뷰 Edit폼 view
		@GetMapping("/reEdit/{no}/{comment_no}")
		public ModelAndView reEdit(@PathVariable("no") int Data_no, @PathVariable("comment_no") int comment_no, CommentVO vo) {
			DataVO reviewEditDetail = service.listSelectOne(Data_no);
			CommentVO reviewDbDetail = service.reviewDbOne(comment_no);
			mav = new ModelAndView();
			mav.addObject("vo",reviewEditDetail);
			mav.addObject("comment_vo",reviewDbDetail);
			log.info(reviewDbDetail.toString());
			mav.setViewName("list/reEdit");
			return mav;
		}
		
		//리뷰 수정DB
		@PostMapping("/reEditOk")
		public ResponseEntity<String> reEditOk(CommentVO vo, HttpSession session) {  
			vo.setUserid((String)session.getAttribute("logId"));

			int s = vo.getContent().indexOf("<img src=\""); 
		    int l = vo.getContent().indexOf("\">", s); 
		    String img = vo.getContent().substring(s+10,l); 
		    log.info("img=>"); 
		    log.info("img=>{}",img); 
		    vo.setThumb(img);
		    
		    int p = vo.getContent().indexOf("<p>"); 
		    int t = vo.getContent().indexOf("</p>", p);
		    String pTag = vo.getContent().substring(p+3,t);
		    
		    if(s>=0) {
		    	pTag = vo.getContent().substring(p+3, s);
		    }

			String bodyTag = "";
			log.info(vo.toString());
			try {
		           int result = service.reviewUpdate(vo);
		           log.info(vo.toString());
		           if(result!=1) {
		        	   bodyTag+="<script>";
		               bodyTag+="  alert('리뷰 수정을 실패했습니다.');";
		               bodyTag+="  history.back();";
		               bodyTag+="</script>";
		           }else {
		        	   log.info("else");
		        	   bodyTag+="<script>";
		               bodyTag+="  alert('리뷰가 수정되었습니다.');";
		               bodyTag+="  window.open('', '_self').close();";
		               bodyTag+="  opener.location.href = '/seoulfloor/list/listView/"+vo.getData_no()+"'";
		               bodyTag+="</script>"; 
		           }
		        }catch(Exception e) {
		        	e.getMessage();
		        	log.info(e.getMessage());
		        	bodyTag+="<script>";
		            bodyTag+="  alert('리뷰 수정을 실패했습니다.');";
		            bodyTag+="  history.back();";
		            bodyTag+="</script>";
		        }
			HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(new MediaType("text","html", Charset.forName("UTF-8")));
	        ResponseEntity<String> entity = new ResponseEntity<String>(bodyTag, headers, HttpStatus.OK);

	        return entity;
		}
		
		//리뷰삭제
		@GetMapping("/reDel")
		public String reDel(int review_no, HttpSession session, int Data_no) {
			String logId = (String)session.getAttribute("logId");
			
			int result=0;
	        try {
	           result = service.reviewDelete(review_no, logId, Data_no);
	        }catch(Exception e) {
	           result=0;
	        }
	        
	      
	         return result+"";
		}
		
		// 리뷰 내용 view
		@GetMapping("/reView/{no}/{comment_no}")
		public ModelAndView reView(@PathVariable("no") int Data_no, @PathVariable("comment_no") int comment_no, CommentVO vo) {
			service.reviewHitCount(comment_no, Data_no);
			DataVO reviewEditDetail = service.listSelectOne(Data_no);
			CommentVO reviewDbDetail = service.reviewDbOne(comment_no);
			mav = new ModelAndView();
			mav.addObject("vo",reviewEditDetail);
			
			if (reviewDbDetail != null) {
		        mav.addObject("comment_vo", reviewDbDetail);
		        log.info(reviewDbDetail.toString());
		    } else {
		        log.info("No review found for comment_no: " + comment_no);
		        // 적절한 처리 - 예: 에러 메시지 또는 기본 값을 추가
		        mav.addObject("comment_vo", new CommentVO()); // 또는 에러 처리용 데이터 추가
		    }
			mav.setViewName("list/reView");
			return mav;
		}
		
		@GetMapping("/reviewSort")
		public List<CommentVO> reviewSort(int Data_no, String sort_opt){
			log.info(sort_opt);
			return service.reviewSortList(Data_no, sort_opt);
		}
	
	
	//병조
	/* 초기 필터 세팅 */
   @GetMapping("filter")
   public List<String> filter(@RequestParam int num) {
      System.out.print(service.filter(num));
      List<String> result = service.filter(num);
      return result;
   }
    /* 필터로 세팅된 Data 불러오기 */
    @PostMapping("/filterlist")
    public List<DataVO> filterList(@RequestParam Map<String, String> params) {
       System.out.println(params);
       System.out.println(service.filterList(params));
       List<DataVO> result = service.filterList(params);
       return result;
    }
    /* Like기능 */
    @GetMapping("/likeState")
    public List<Map<String, Integer>> likeState(@RequestParam int action, @RequestParam int no, HttpSession session) {
    	String userid = (String)session.getAttribute("logId");
    	int result = 0;
    	LikeVO resultVO = service.getlikeState(no, userid);	//여기서 좋아요 있는지 조회
    	if(resultVO != null && resultVO.getData_no() != 0) {
    		result = 1;
    	}
    	System.out.println("userid = " + userid);
    	System.out.println(resultVO + ", " + result);
    	if(action == 1 && userid != null && !userid.equals("")) {	// 사람이 버튼으로 누를시 발동
    		 if(result == 0) {
    			 service.updatelikeState(no, userid);
    			 result = 1;
    		 }else {
    			 service.deletelikeState(no, userid);
    			 result = 0;
    		 }
    	}
    	
    	int count = service.getLikeCount(no);	// 총 좋아요 수 조회
    	
    	List<Map<String, Integer>> list = new ArrayList<Map<String, Integer>>();
    	Map<String, Integer> data = new HashMap<String, Integer>();
    	data.put("result", result);
    	data.put("count", count);
    	list.add(data);
    	return list;
    }
}
