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
	
																																																																																																																																																																																																																																																																
	
	//로그인폼
	@GetMapping("/login")
		public ModelAndView login() {
		mav = new ModelAndView();
		mav.setViewName("user/login");
		return mav;
	}
	
	//로그인(DB조회)
	//로그인(DB조회)
	   @PostMapping("/loginOk")
	   public String loginOk(MemberVO vo, HttpSession session) {
	      String url = "";
	      System.out.println(vo.toString());

	      MemberVO resultVo = service.loginOk(vo); // 아이디와 비번이 있으면 담고, 없으면 null이 돌아온다.
	      System.out.println("resultVo" + resultVo);
	      // System.out.println(resultVo.toString());
	      if(resultVo==null) {//로그인 실패 -> 로그인폼
	         url = "redirect:/user/login";
	      }else {//로그인 성공하면 -> 세션로그인 정보기록 -> 홈
	         session.setAttribute("logId", resultVo.getUserid());
	         session.setAttribute("logName", resultVo.getUsername());
	         session.setAttribute("logStatus" ,"Y");
	         System.out.println(resultVo.toString() + ",  " + session.getAttribute("logStatus"));
	         url = "redirect:/main/mainPage"; // redirect는 뷰페이지로 이동하지 않고 원하는 컨트롤러 매핑으로 바로 이동한다.   
	      }
	      return url;
	   }
	 		//로그아웃
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
	
	//마이페이지(스탬프)
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
	
	//회원정보수정폼
	@GetMapping("/memberEdit")
	public ModelAndView memberEdit(HttpSession session) {
		//세션에 있는 로그인 아이디 -> 해당아이디의 정보를 DB에서 select하기
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
  

	// 회원 정보 수정 처리 (POST 요청)
	@PostMapping("/memberEdit")
	public ModelAndView memberEditOk(MemberVO vo, HttpSession session) {
		mav = new ModelAndView();
		System.out.print(vo);
	    // 회원 정보 업데이트 로직
	    vo.setUserid((String) session.getAttribute("logId"));
	    service.memberEdit(vo);
	    
	    mav.setViewName("main/mainPage");

	    return mav; // 수정 후 다시 회원 정보 수정 페이지로 이동
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
		if (profileImage != null && !profileImage.isEmpty()) {  // 파일이 null이 아니고 비어있지 않을 때
	        try {
	            fName = profileImage.getOriginalFilename();
	            //업로드 파일 확장자
	            File file = new File(path, fName);
	            profileImage.transferTo(file);
	            System.out.println(fName);
	            // 전체 파일 경로를 DB에 저장	          
	            dVO.setUser_img(fName);  // DB에 전체 파일 경로 저장
	            
	        } catch (Exception e) {
	            e.printStackTrace();  // 오류 출력
	        }
	    }
        System.out.print(dVO);
      //update
        String body ="<script>";
        try {
        	//원래꺼       	
        	
        	int result = service.updateUserProfile(dVO);	// 사진 추가 가능하게
            if (result == 0){ //업데이트 실패 - 새로운 첨부 지우기
                if (fName != null) {
                    fileDelete(path, fName);//새로운 업로드 삭제
                }
                body += " history.go(-1);";

            } else {
                if (delFile != null && !delFile.equals("")) {
                    //fileDelete(path, delFile);//원래보관지우기
                }
          body += "alert('업데이트 성공!'); location.href='" + session.getServletContext().getContextPath() + "/user/memberEdit/';";
 
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
			 String userid = (String) session.getAttribute("logId"); // 세션에서 사용자 ID 가져오기
		    
			 // x와 y 배열이 동일한 길이인지 확인
		       
		         // StampVO 객체 생성 및 설정
		            StampVO stampVO = new StampVO();
		            stampVO.setUserid(userid);
		        // 각 좌표를 처리하여 데이터베이스에 저장
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
        return "user/find-password"; // 이 페이지는 실제로 존재해야 합니다
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

	
	

	
	
	
	

