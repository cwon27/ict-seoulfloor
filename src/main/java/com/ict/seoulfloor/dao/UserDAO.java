package com.ict.seoulfloor.dao;

import java.util.List;

import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.MemberVO;
import com.ict.seoulfloor.vo.StampVO;

public interface UserDAO {
	//로그인
	public MemberVO loginOk(MemberVO vo);
				
	//아이디 중복검사
	public int idDoubleCheck(String userid);
	
	//회원등록
	public int memberInsert(MemberVO vo);
	
	//회원선택
	public MemberVO memberSelect(String userid);
	
	//회원수정
	public int memberEdit(MemberVO vo);
	
	public int updateUserProfile(MemberVO vo);
	//프로필사진수정
	// public void updateUserProfile(String userid, String filePath);
	
	//프로필사진등록
	public MemberVO saveProfileImage(String userid); 
	
	// 좋아요한 리스트 목록
	public List<DataVO> likeList(String userid);
	
	//도장찍기 
	public int saveStamp(StampVO stampVO);
	
	public int updateStamp(StampVO stampVO);
	
	//도장찍은목록 가져오기
	public String getStampByUser(String userid);	
	
	//패스워드받기
	public String findpassword(String userid, String email, String tel);
}
