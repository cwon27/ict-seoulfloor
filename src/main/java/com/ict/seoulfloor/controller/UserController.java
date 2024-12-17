package com.ict.seoulfloor.controller;

import java.io.Console;
import java.io.File;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ict.seoulfloor.vo.MemberVO;
import com.ict.seoulfloor.vo.StampVO;

import lombok.experimental.var;

import com.ict.seoulfloor.vo.DataVO;
import com.fasterxml.jackson.core.JsonParser;
import com.ict.seoulfloor.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	@Inject
	UserService service;
	ModelAndView mav = null;
	
																																																																																																																																																																																																																																																																
	
	//�α�����
	@GetMapping("/login")
		public ModelAndView login() {
		mav = new ModelAndView();
		mav.setViewName("user/login");
		return mav;
	}
	
	//�α���(DB��ȸ)
	//�α���(DB��ȸ)
	   @PostMapping("/loginOk")
	   public String loginOk(MemberVO vo, HttpSession session) {
	      String url = "";
	      System.out.println(vo.toString());

	      MemberVO resultVo = service.loginOk(vo); // ���̵�� ����� ������ ���, ������ null�� ���ƿ´�.
	      System.out.println("resultVo" + resultVo);
	      // System.out.println(resultVo.toString());
	      if(resultVo==null) {//�α��� ���� -> �α�����
	         url = "redirect:/user/login";
	      }else {//�α��� �����ϸ� -> ���Ƿα��� ������� -> Ȩ
	         session.setAttribute("logId", resultVo.getUserid());
	         session.setAttribute("logName", resultVo.getUsername());
	         session.setAttribute("logStatus" ,"Y");
	         System.out.println(resultVo.toString() + ",  " + session.getAttribute("logStatus"));
	         url = "redirect:/main/mainPage"; // redirect�� ���������� �̵����� �ʰ� ���ϴ� ��Ʈ�ѷ� �������� �ٷ� �̵��Ѵ�.   
	      }
	      return url;
	   }
	 		//�α׾ƿ�
	   @GetMapping("/logout")
	   public String logout(HttpSession session) {
	      session.invalidate();
	      /*
	       * mav = new ModelAndView(); 
	       * mav.setViewName("main/mainPage"); 
	       * return mav;
	       */
	      return "redirect:/main/mainPage";
	   }
	@PostMapping("/signOk")
	public ModelAndView signOk(MemberVO vo) {
		mav = new ModelAndView();
		int result = service.memberInsert(vo);
		mav.addObject("result", result);
		mav.setViewName("/user/joinResult");
		return mav;
	}
	
	//����������(������)
    @GetMapping("/memberStamp")
    public ModelAndView memberStamp(HttpSession session) {
       String userid = (String)session.getAttribute("logId");
        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/memberStamp");
        mav.addObject("vo", service.memberSelect(userid));
        return mav;
}

	@GetMapping("/getLikeList")
	@ResponseBody
	public List<DataVO> getLikeList(HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		List<DataVO> likelist = service.likeList(userid);
		// System.out.print(likelist);
		return likelist;
	}
	
	//ȸ������������
	@GetMapping("/memberEdit")
	public ModelAndView memberEdit(HttpSession session) {
		//���ǿ� �ִ� �α��� ���̵� -> �ش���̵��� ������ DB���� select�ϱ�
		String path = session.getServletContext().getRealPath("/upload");
		String userid = (String)session.getAttribute("logId");
		MemberVO vo = service.memberSelect(userid);
		System.out.println(vo);
		ModelAndView  mav = new ModelAndView();
		System.out.println(path);
		String img = path + "\\" + vo.getUser_img();
		System.out.println(img);
		mav.addObject("path", img);
		mav.addObject("vo",vo);
		mav.setViewName("user/memberEdit");
		
		return mav;
	}	
  

	// ȸ�� ���� ���� ó�� (POST ��û)
	@PostMapping("/memberEdit")
	public ModelAndView memberEditOk(MemberVO vo, HttpSession session) {
		mav = new ModelAndView();
		System.out.print(vo);
	    // ȸ�� ���� ������Ʈ ����
	    vo.setUserid((String) session.getAttribute("logId"));
	    service.memberEdit(vo);
	    
	    mav.setViewName("main/mainPage");

	    return mav; // ���� �� �ٽ� ȸ�� ���� ���� �������� �̵�
	}

	@PostMapping("/uploadProfileImage")
	public ResponseEntity<String> uploadProfileImage(
										 MultipartFile profileImage,
										 @RequestParam("delFile") String delFile,
										 HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		String path = session.getServletContext().getRealPath("/upload");
		System.out.println(path);
		System.out.println(profileImage.getSize());
		MemberVO dVO = service.memberSelect(userid);
		
		String fName = null;
		if (profileImage != null && !profileImage.isEmpty()) {  // ������ null�� �ƴϰ� ������� ���� ��
	        try {
	            fName = profileImage.getOriginalFilename();
	            //���ε� ���� Ȯ����
	            File file = new File(path, fName);
	            profileImage.transferTo(file);
	            System.out.println(fName);
	            // ��ü ���� ��θ� DB�� ����	          
	            dVO.setUser_img(fName);  // DB�� ��ü ���� ��� ����
	            
	        } catch (Exception e) {
	            e.printStackTrace();  // ���� ���
	        }
	    }
        System.out.print(dVO);
      //update
        String body ="<script>";
        try {
        	//������       	
        	
        	int result = service.updateUserProfile(dVO);	// ���� �߰� �����ϰ�
            if (result == 0){ //������Ʈ ���� - ���ο� ÷�� �����
                if (fName != null) {
                    fileDelete(path, fName);//���ο� ���ε� ����
                }
                body += " history.go(-1);";

            } else {
                if (delFile != null && !delFile.equals("")) {
                    //fileDelete(path, delFile);//�������������
                }
          body += "alert('������Ʈ ����!'); location.href='" + session.getServletContext().getContextPath() + "/user/memberEdit/';";
 
            }
       }catch(Exception e){
            if (fName != null) {
                //fileDelete(path, fName);
            }
            body += " history.go(-1);";
        }
        body += "</script>";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("text", "html",Charset.forName("UTF-8")));
        return new ResponseEntity<String>(body, headers, HttpStatus.OK);
	}
		

	public void fileDelete(String path, String name){
	    File f = new File(path,name);
	    if(f.exists()){
	        f.delete();
	    }else{
	
	    }
	}
	
	@PostMapping("/saveStamp")
	@ResponseBody
	public String saveStamp(String[] x,String[] y, HttpSession session){
         System.out.println("aaaa"+ Arrays.toString(x));
         System.out.println("aaaa"+ Arrays.toString(y));
         int stampmap = 0;
		 try {
			 String userid = (String) session.getAttribute("logId"); // ���ǿ��� ����� ID ��������
		    
			 // x�� y �迭�� ������ �������� Ȯ��
		       
		         // StampVO ��ü ���� �� ����
		            StampVO stampVO = new StampVO();
		            stampVO.setUserid(userid);
		        // �� ��ǥ�� ó���Ͽ� �����ͺ��̽��� ����
		        // total = 492.5/32.5/33/3.33/
		            
		        String total = "";    
		            
		        for (int i = 0; i < x.length; i++) {
		            total += x[i]+"/"+y[i]+"/";	 
		        }   
		        stampVO.setContent(total);

		    
		    if(service.getStampByUser(userid) != null) {
		    	stampmap = service.updateStamp(stampVO);
		    }else {
		    	stampmap = service.saveStamp(stampVO);
		    }
		    
		    System.out.println(stampmap);
	       
	        
	    } catch (Exception e) {
	    	e.printStackTrace();

	    }
		 return stampmap+"";
	}
		
		
		
	
	@GetMapping("/getStampList")
	@ResponseBody
	public List<String> getStampList(HttpSession session) {
		String userid = (String) session.getAttribute("logId");
		String resultString = service.getStampByUser(userid);
		String[] values = resultString.split("/");
		List<String> list = Arrays.asList(values);

		System.out.println(list);
		return list;
	}
    @GetMapping("/password/find")
    public String showFindPasswordPage() {
        return "user/find-password"; // �� �������� ������ �����ؾ� �մϴ�
    }
	    
    @PostMapping("/findpassword")
    @ResponseBody
    public String findpassword(@RequestParam String userid, @RequestParam String email, @RequestParam String tel) {
    	
    	System.out.println(userid + email + tel);
    	
    	String result = service.findpassword(userid, email, tel);
    	if(result == null) { 
    		result = "1"; 
    	}
    	System.out.println(result);

    	return result;
    }

    
    
}

	
	

	
	
	
	

