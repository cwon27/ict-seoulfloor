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

	   // ���� �κ� ///////////////////////////////////////////////////////////////////////////////////////
	   
	   // 1. tradition
	   // ����Ʈ �ҷ�����
	   @GetMapping("/traditionalList")
	   public ModelAndView getTradList() {
	      mav = new ModelAndView();
	      List<DataVO> dataList = service.getTradList();
	      mav.addObject("dataList", dataList);
	      mav.setViewName("list/traditionalList");
	      return mav;
	   }
	   
	   // �˻�, ����¡, ����
	   @GetMapping("/search")
	    public Map<String, Object> searchLists(
	            @RequestParam(value = "keyword", required = false) String keyword,
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "pageSize", defaultValue = "12") int pageSize,
	            @RequestParam(value = "sort", defaultValue = "latest") String sort) { // sort �߰�

	      System.out.println("Controller - �˻���: " + keyword + ", ������: " + page + ", ������ ũ��: " + pageSize + ", ����: " + sort);
	        
	       int totalRecords;
	        List<DataVO> results;

	        if (keyword == null || keyword.trim().isEmpty()) {
	            // �˻�� ������ ��ü ����Ʈ ��ȸ
	            totalRecords = service.getTotalCount(null);  // ��ü ���ڵ� ��
	            results = service.searchLists(null, page, pageSize, sort);  // ��ü ����Ʈ ��ȸ
	            System.out.println("��ü ���ڵ� ��: " + totalRecords);
	        } else {
	            // �˻�� ���� ��
	            totalRecords = service.getTotalCount(keyword);  // �˻��� ���ڵ� ��
	            results = service.searchLists(keyword, page, pageSize, sort);  // �˻��� ����Ʈ ��ȸ
	            System.out.println("�˻��� ���ڵ� ��: " + totalRecords);
	        }
	        
	        System.out.println("�˻� ���: " + results);
	        Map<String, Object> response = new HashMap<String, Object>();
	        response.put("totalRecords", totalRecords);
	        response.put("results", results);
	        return response;
	    }
	   
	   // 2. hip
	   
	   // ����Ʈ �ҷ�����
	   @GetMapping("/hipList")
	   public ModelAndView getHipList() {
	      mav = new ModelAndView();
	      List<DataVO> dataList = service.getHipList();
	      mav.addObject("dataList", dataList);
	      mav.setViewName("list/hipList");
	      return mav;
	   }
	   
	   // �˻�, ����¡, ����
	   @GetMapping("/searchHip")
	    public Map<String, Object> searchHipLists(
	            @RequestParam(value = "keyword", required = false) String keyword,
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "pageSize", defaultValue = "12") int pageSize,
	            @RequestParam(value = "sort", defaultValue = "latest") String sort) { // sort �߰�

	      System.out.println("Controller - �˻���: " + keyword + ", ������: " + page + ", ������ ũ��: " + pageSize + ", ����: " + sort);
	        
	      int totalRecords;
	        List<DataVO> results;

	        if (keyword == null || keyword.trim().isEmpty()) {
	            // �˻�� ������ ��ü ����Ʈ ��ȸ
	            totalRecords = service.getTotalHipCount(null);  // ��ü ���ڵ� ��
	            results = service.searchHipLists(null, page, pageSize, sort);  // ��ü ����Ʈ ��ȸ
	            System.out.println("��ü ���ڵ� ��: " + totalRecords);
	        } else {
	            // �˻�� ���� ��
	            totalRecords = service.getTotalHipCount(keyword);  // �˻��� ���ڵ� ��
	            results = service.searchHipLists(keyword, page, pageSize, sort);  // �˻��� ����Ʈ ��ȸ
	            System.out.println("�˻��� ���ڵ� ��: " + totalRecords);
	        }
	        
	        System.out.println("�˻� ���: " + results);
	        Map<String, Object> response = new HashMap<String, Object>();
	        response.put("totalRecords", totalRecords);
	        response.put("results", results);
	        return response;
	    }
	   

	   // ���� �κ� �� ///////////////////////////////////////////////////////////////////////////////////////

	// ä�� �κ�
		// �������� view
		@GetMapping("/listView/{no}")
		public ModelAndView listView(@PathVariable("no") int no, HttpSession session) {
			String logId= (String)session.getAttribute("logId");//session�� �ִ� logId�� ������ 
			
			service.hitCount(no,logId);
			DataVO detailView = service.listSelectOne(no);
			log.info(detailView.toString());

			mav = new ModelAndView();
			mav.addObject("vo", detailView);
			mav.setViewName("list/listView");

			return mav;
		}

		// ���� write�� view
		@GetMapping("/reWrite/{no}")
		public ModelAndView reWrite(@PathVariable("no") int Data_no, CommentVO vo) {
			DataVO reviewDetail = service.listSelectOne(Data_no);
			mav = new ModelAndView();
			mav.addObject("vo",reviewDetail);
			mav.setViewName("list/reWrite");
			return mav;
		}

		//���� write(DB)
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
		               bodyTag+="  alert('���� ����� �����߽��ϴ�.');";
		               bodyTag+="  history.back();";
		               bodyTag+="</script>";
		           }else {
		        	   bodyTag+="<script>";
		               bodyTag+="  alert('���䰡 ��ϵǾ����ϴ�.');";
		               bodyTag+="  window.open('', '_self').close();";
		               bodyTag+="  opener.location.href = '/seoulfloor/list/listView/"+vo.getData_no()+"'";
		               bodyTag+="</script>"; 
		           }
		        }catch(Exception e) {
		        	bodyTag+="<script>";
		            bodyTag+="  alert('���� ����� �����߽��ϴ�.');";
		            bodyTag+="  history.back();";
		            bodyTag+="</script>";
		        }
			HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(new MediaType("text","html", Charset.forName("UTF-8")));
	        ResponseEntity<String> entity = new ResponseEntity<String>(bodyTag, headers, HttpStatus.OK);

	        return entity;
		}
		
		//���� ����Ʈ �����ֱ�
		@GetMapping("/reviewList")
		public List<CommentVO> reviewList(int Data_no){
			return service.reviewSelectList(Data_no);
		}
		
		//���� ���� ��� �����ֱ�
		@GetMapping("/reviewGradeAvg")
		public double reviewGradeAvg(int Data_no, CommentVO vo){
			CommentVO vo1 = service.reviewGradeAvg(Data_no);
			double grade_avg = vo1.getGrade_avg();
			 
			return grade_avg;
		}
		
		// ���� Edit�� view
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
		
		//���� ����DB
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
		               bodyTag+="  alert('���� ������ �����߽��ϴ�.');";
		               bodyTag+="  history.back();";
		               bodyTag+="</script>";
		           }else {
		        	   log.info("else");
		        	   bodyTag+="<script>";
		               bodyTag+="  alert('���䰡 �����Ǿ����ϴ�.');";
		               bodyTag+="  window.open('', '_self').close();";
		               bodyTag+="  opener.location.href = '/seoulfloor/list/listView/"+vo.getData_no()+"'";
		               bodyTag+="</script>"; 
		           }
		        }catch(Exception e) {
		        	e.getMessage();
		        	log.info(e.getMessage());
		        	bodyTag+="<script>";
		            bodyTag+="  alert('���� ������ �����߽��ϴ�.');";
		            bodyTag+="  history.back();";
		            bodyTag+="</script>";
		        }
			HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(new MediaType("text","html", Charset.forName("UTF-8")));
	        ResponseEntity<String> entity = new ResponseEntity<String>(bodyTag, headers, HttpStatus.OK);

	        return entity;
		}
		
		//�������
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
		
		// ���� ���� view
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
		        // ������ ó�� - ��: ���� �޽��� �Ǵ� �⺻ ���� �߰�
		        mav.addObject("comment_vo", new CommentVO()); // �Ǵ� ���� ó���� ������ �߰�
		    }
			mav.setViewName("list/reView");
			return mav;
		}
		
		@GetMapping("/reviewSort")
		public List<CommentVO> reviewSort(int Data_no, String sort_opt){
			log.info(sort_opt);
			return service.reviewSortList(Data_no, sort_opt);
		}
	
	
	//����
	/* �ʱ� ���� ���� */
   @GetMapping("filter")
   public List<String> filter(@RequestParam int num) {
      System.out.print(service.filter(num));
      List<String> result = service.filter(num);
      return result;
   }
    /* ���ͷ� ���õ� Data �ҷ����� */
    @PostMapping("/filterlist")
    public List<DataVO> filterList(@RequestParam Map<String, String> params) {
       System.out.println(params);
       System.out.println(service.filterList(params));
       List<DataVO> result = service.filterList(params);
       return result;
    }
    /* Like��� */
    @GetMapping("/likeState")
    public List<Map<String, Integer>> likeState(@RequestParam int action, @RequestParam int no, HttpSession session) {
    	String userid = (String)session.getAttribute("logId");
    	int result = 0;
    	LikeVO resultVO = service.getlikeState(no, userid);	//���⼭ ���ƿ� �ִ��� ��ȸ
    	if(resultVO != null && resultVO.getData_no() != 0) {
    		result = 1;
    	}
    	System.out.println("userid = " + userid);
    	System.out.println(resultVO + ", " + result);
    	if(action == 1 && userid != null && !userid.equals("")) {	// ����� ��ư���� ������ �ߵ�
    		 if(result == 0) {
    			 service.updatelikeState(no, userid);
    			 result = 1;
    		 }else {
    			 service.deletelikeState(no, userid);
    			 result = 0;
    		 }
    	}
    	
    	int count = service.getLikeCount(no);	// �� ���ƿ� �� ��ȸ
    	
    	List<Map<String, Integer>> list = new ArrayList<Map<String, Integer>>();
    	Map<String, Integer> data = new HashMap<String, Integer>();
    	data.put("result", result);
    	data.put("count", count);
    	list.add(data);
    	return list;
    }
}
